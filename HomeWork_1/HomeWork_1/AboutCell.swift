//
//  AboutCell.swift
//  HomeWork_1
//
//  Created by Сабиров Мльнур Марсович on 11.10.2024.
//



import UIKit

class AboutCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with profile: UserProfile) {
        fullNameLabel.text = profile.fullName
        ageLabel.text = "\(profile.age) лет"
        cityLabel.text = profile.city
    }
}
