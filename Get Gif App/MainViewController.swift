//
//  ViewController.swift
//  Get Gif App
//
//  Created by Dmitry Sachkov on 10.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    private let networkApi = NetworkApi.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.title = "Get Gif App"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        let url = "https://api.giphy.com/v1/gifs/search?api_key=m8DMTiVx53HrYTLDatD5nFJ7nZmYVHiX&q=\(searchText)&offset=0&rating=g&lang=en"
        var images = [Images]()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (_) in
            self.networkApi.fetchGif(url: url) { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    let image = data.data
                    images = image.compactMap { $0.images }
                    let vc = self?.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
                    vc.images = images
                    self?.navigationController?.pushViewController(vc, animated: true)
                    searchBar.text = ""
                }
            }
        })
    }
}
