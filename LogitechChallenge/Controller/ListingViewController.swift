//
//  ViewController.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    lazy var viewModel: MovieListViewModel = {
        return MovieListViewModel()
    }()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init the static view
        initView()
        
        // init view model
        initVM()
    }
    
    func initView() {
        // Initialise view for static contents
    }

    func initVM() {
        
        // Native binding using closures
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
                
        viewModel.callApi()
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - UICollectionView protocols

extension ListingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifier.CollectionView.cell, for: indexPath as IndexPath) as? MyCollectionViewCell else {
            fatalError("Cell doesn't exist in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.initializeWithVM(cellViewModel: cellVM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = viewModel.itemSize()
        return CGSize(width: itemSize, height:itemSize*1.5)
    }
    
}

extension ListingViewController {
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! DetailViewController
        if let mov = (sender as? MyCollectionViewCell)?.cellVM?.movie {
            destinationVC.movie = mov
        }
    }

}
