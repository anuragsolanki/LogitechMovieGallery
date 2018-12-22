//
//  MovieListViewModel.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewModel {
    
    let webHelper: WebServiceProtocol
    
    var movies: [Movie] = []
    
    let reachability = Reachability()!

    private var cellViewModels: [MovieListCellViewModel] = [MovieListCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var reloadCollectionViewClosure: (()->())?
    var showAlertClosure: (()->())?


    init( apiService: WebServiceProtocol = WebHelper()) {
        self.webHelper = apiService
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MovieListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( movie: Movie ) -> MovieListCellViewModel {
        let cellVM = MovieListCellViewModel()
        cellVM.thumbnailImageURL = movie.Poster ?? movie.PosterWithWhitespace ?? ""
        cellVM.name = movie.Title
        cellVM.movie = movie
        cellVM.movieListViewModel = self
        return cellVM
    }
    
    private func processFetchedEntries( movieArr: [Movie] ) {
        self.movies = movieArr
        var vms = [MovieListCellViewModel]()
        for movie in movies {
            vms.append( createCellViewModel(movie: movie) )
        }
        self.cellViewModels = vms
    }
    
    func callApi() {
        if !checkForNetworkReachability() {
            return
        }
        ProgressHUD.show(message: "Fetching Movies")
        webHelper.callApi(completion: { [weak self] (entries) in
            ProgressHUD.hide()
            if entries.count == 0 {
                self?.alertMessage = "Oops! Something went wrong."
                return
            }
            
            let result = entries.filter( { $0 != nil && ($0?.Poster != nil || $0?.PosterWithWhitespace != nil) } )
            if let resultAsMovies = result as? [Movie] {
                self?.movies =  resultAsMovies
            }
            self?.processFetchedEntries(movieArr: self!.movies)
        })
    }
        
    func itemSize() -> CGFloat {
        return (UIScreen.main.bounds.width - Constants.Float.padding)/Constants.Float.numberOfColumns
    }
}

// Internet check
extension MovieListViewModel {
    
    // Check for network connection
    fileprivate func checkForNetworkReachability() -> Bool {
        if reachability.connection == .none {
            self.alertMessage = "Please check your internet connection and open app again."
            return false
        }
        return true
    }

}
