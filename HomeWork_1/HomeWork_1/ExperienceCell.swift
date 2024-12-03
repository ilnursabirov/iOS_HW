//
//  ExperienceCell.swift
//  HomeWork_1
//
//  Created by Сабиров Мльнур Марсович on 01.10.2024.
//

import UIKit

class ExperienceCell: UITableViewCell {
    
    let yearLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(yearLabel)
        contentView.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(year: String, description: String) {
        yearLabel.text = year
        descriptionLabel.text = description
    }
}
