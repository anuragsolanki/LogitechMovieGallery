//
//  MyCollectionViewCell.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit
import SDWebImage

class MyCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    weak var cellVM: MovieListCellViewModel?

    func initializeWithVM(cellViewModel: MovieListCellViewModel) {
        cellVM = cellViewModel
        guard let vm = cellVM else {
            return
        }
        thumbnail.sd_setImage(with: URL(string: vm.thumbnailImageURL.trim()), placeholderImage: UIImage(named: "thumbnail"), options: SDWebImageOptions.continueInBackground, completed: nil)
        nameLabel.text = vm.name
    }
    
}
