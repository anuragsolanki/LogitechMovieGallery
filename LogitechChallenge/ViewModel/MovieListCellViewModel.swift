//
//  MovieListCellViewModel.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit

class MovieListCellViewModel {
    
    var thumbnailImageURL: String = ""
    var name: String = ""
    
    var movie: Movie?
    
    weak var movieListViewModel: MovieListViewModel?

    
}
