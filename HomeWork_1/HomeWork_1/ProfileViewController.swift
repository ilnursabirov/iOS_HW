//
//  ProfileViewController.swift
//  HomeWork_1
//
//  Created by Сабиров Мльнур Марсович on 01.10.2024.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableView = UITableView()
    
    var userProfile: UserProfile = UserProfile(
        fullName: "Иван Иванов",
        age: 30,
        city: "Москва",
        workExperience: [("2015", "Разработчик ПО"), ("2018", "Старший разработчик")],
        photos: ["photo1", "photo2", "photo3"]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "AboutCell", bundle: nil), forCellReuseIdentifier: "AboutCell")
        tableView.register(ExperienceCell.self, forCellReuseIdentifier: "ExperienceCell")
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        
        view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return userProfile.workExperience.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
            cell.configure(with: userProfile)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceCell
            let experience = userProfile.workExperience[indexPath.row]
            cell.configure(year: experience.year, description: experience.description)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            cell.configure(with: userProfile.photos)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "О себе"
        case 1:
            return "Опыт работы"
        case 2:
            return "Фото"
        default:
            return nil
        }
    }
}
