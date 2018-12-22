//
//  DetailViewController.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!

    var movie: Movie!
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel(movie: self.movie)
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = viewModel.movieDetails()
        image.sd_setImage(with: URL(string: viewModel.imageUrl().trim()), placeholderImage: UIImage(named: "thumbnail"), options: .continueInBackground, completed: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fix for scroll issue on iOS 9
        textView.setContentOffset(.zero, animated: true)
    }

}
