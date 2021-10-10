//
//  CustomCell.swift
//  Get Gif App
//
//  Created by Dmitry Sachkov on 10.10.2021.
//

import UIKit
import Kingfisher
import Gifu

class CustomCell: UICollectionViewCell {
    static let identifaer = "CustomCell"
    
    private let imageView: GIFImageView = {
        let imageView = GIFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .none
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        imageView.frame = CGRect(x: 0,
                                 y: 5,
                                 width: contentView.frame.size.width,
                                 height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        imageView.image = nil
    }
    
    func setupCell(image: String) {
        guard let url = URL(string: image) else { return }
        imageView.kf.setImage(with: url)
    }
}
