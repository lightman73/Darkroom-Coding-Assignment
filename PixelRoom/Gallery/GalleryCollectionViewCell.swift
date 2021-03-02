//
//  GalleryCollectionViewCell.swift
//  PixelRoom
//
//  Created by Igor Lipovac on 01/03/2021.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    let photoView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
        contentView.backgroundColor = .black
        photoView.layer.cornerRadius = 6
        photoView.layer.masksToBounds = true
        photoView.contentMode = .scaleAspectFill
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    func configure(with image: UIImage?) {
        if let image = image {
            photoView.image = image
            photoView.contentMode = .scaleAspectFill
        } else {
            photoView.image = UIImage(named: "icon-placeholder")
            photoView.contentMode = .center
        }
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.photoView.alpha = self.isSelected ? 0.75 : 1
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.photoView.alpha = self.isHighlighted ? 0.75 : 1
            }
        }
    }
}
