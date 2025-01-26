//
//  PostCell.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import UIKit

final class PostCell: UITableViewCell {
    static let identifier = "PostCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private let postTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 100) // Размер изображения
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var images: [UIImage] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(postTextLabel)
        contentView.addSubview(imageCollectionView)
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postTextLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            postTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageCollectionView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 8),
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 120), // Высота коллекции
            
            contentView.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with post: Post) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateLabel.text = dateFormatter.string(from: post.date)
            
        postTextLabel.text = post.text
            
        images = Array(post.images.prefix(2)) // Отображаем максимум 2 изображения
        imageCollectionView.reloadData()
        }
}

extension PostCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
}

