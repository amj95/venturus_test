//
//  ViewController.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import UIKit
import Combine
import GoneVisible

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var lbError: UILabel!
    
    var mHomeViewModel: HomeViewModel = HomeViewModel(getImages: GetImages(imagesRepository: ImagesRepository.getInstance(remoteDataSource: ImagesRemoteDataSource.getInstance())))
    private var subscriptions = Set<AnyCancellable>()
    private var dataArray: [ImageData] = []
    var refresher:UIRefreshControl!
    var columns = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        let nib = UINib(nibName: "ImageCell",bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        viewError.isHidden = true
        setupProcessChain()
        mHomeViewModel.loadData()
    }
    
    @objc func loadData() {
        mHomeViewModel.loadData()
    }
    
    func setupProcessChain() {
        mHomeViewModel
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                $0 ? self.showRefresher() : self.hideRefresher()
            }).store(in: &subscriptions)
        
        mHomeViewModel
            .$dataArray
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.dataArray = $0
                self.collectionView.reloadData()
            }).store(in: &subscriptions)
        
        mHomeViewModel
            .$result
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                $0.count > 0 ? self.showError(errorDescription: $0) : self.hideError()
            }).store(in: &subscriptions)
    }
    
    func showRefresher() {
        self.refresher.beginRefreshing()
    }
    
    func hideRefresher() {
        self.refresher.endRefreshing()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        columns = toInterfaceOrientation == .portrait ? CGFloat(1.0) : CGFloat(2.0)
        self.collectionView.reloadData()
    }
    
    func showError(errorDescription: String) {
        viewError.isHidden = false
        lbError.text = errorDescription
    }
    
    func hideError() {
        viewError.isHidden = true
    }
    
}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageViewCell
        let data = dataArray[indexPath.row]
        cell.prepare(up: String(data.ups), comment: String(data.commentCount), views: String(data.views), imageUrl: data.images?.first?.link)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / columns
        let yourHeight = CGFloat(310.0)
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let showCell = cell as? ImageViewCell {
            showCell.loadImage()
        }
        if (indexPath.row == dataArray.count - 1 ) {
            mHomeViewModel.loadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

