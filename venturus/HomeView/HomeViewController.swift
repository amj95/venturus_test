//
//  ViewController.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var refresher:UIRefreshControl!
    var mHomeViewModel: HomeViewModel = HomeViewModel(getImages: GetImages())
    private var isLoadingSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        setupProcessChain()
        mHomeViewModel.loadData()
    }
    
    @objc func loadData() {
        mHomeViewModel.loadData()
    }
    
    func setupProcessChain() {
        isLoadingSubscriber = mHomeViewModel
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                if ($0) {
                    self.showRefresher()
                } else {
                    self.hideRefresher()
                }
            })
    }
    
    func showRefresher() {
        self.refresher.beginRefreshing()
    }
    
    func hideRefresher() {
        self.refresher.endRefreshing()
    }

}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

