//
//  SecondViewController.swift
//  Get Gif App
//
//  Created by Dmitry Sachkov on 10.10.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    var images = [Images]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(images.count)
        setupUI()
    }

    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 15,
                                           bottom: 10,
                                           right: 15)
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.width)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifaer)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .none
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0,
                                       y: 0,
                                       width: view.frame.width,
                                       height: view.frame.height)
    }
}

extension SecondViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifaer, for: indexPath) as! CustomCell
        let url = images[indexPath.row].previewGIF.url
        cell.setupCell(image: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 30,
                      height: view.frame.width / 2 - 30)
    }
}
