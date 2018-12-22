//
//  Constants.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import Foundation
import UIKit

@objc class Constants: NSObject {
    
    struct Identifier {
        
        struct CollectionView {
            static let cell         = "CollectionCell"
        }
    }
    
    struct URL {
        static let apiURL       = "https://api.myjson.com/bins/18buhu"
    }
    
    struct Float {
        static let padding: CGFloat          = 40.0
        static let numberOfColumns: CGFloat  = 3.0
    }
    
    
}
