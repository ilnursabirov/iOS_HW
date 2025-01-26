//
//  ImageCell.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()

    private let addIconLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(addIconLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addIconLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            addIconLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addIconLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage) {
        imageView.image = image
        addIconLabel.isHidden = true
    }

    func configureAsAddButton() {
        imageView.image = nil
        addIconLabel.isHidden = false
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.gray.cgColor
    }
}


