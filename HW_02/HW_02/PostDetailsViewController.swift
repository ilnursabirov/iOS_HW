//
//  PostDetailsViewController.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import UIKit

final class PostDetailsViewController: UIViewController {
    private var post: Post
    var onPostUpdated: ((Post) -> Void)? // Замыкание для передачи изменений

    private let textView = UITextView()
    private let collectionView: UICollectionView

    init(post: Post) {
        self.post = post

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        displayPostData()
    }

    private func setupNavigationBar() {
        title = "Post Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPost))
    }

    private func setupViews() {
        view.addSubview(textView)
        view.addSubview(collectionView)

        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 150),

            collectionView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func displayPostData() {
        textView.text = post.text
        collectionView.reloadData()
    }

    @objc private func editPost() {
        let createVC = CreatePostViewController()
        createVC.postToEdit = post // Передаём текущий пост для редактирования
        createVC.onPostCreated = { [weak self] updatedPost in
            guard let self = self else { return }
            self.post = updatedPost
            self.displayPostData() // Обновляем UI с новыми данными
            self.onPostUpdated?(updatedPost) // Передаём изменения в вызывающий контроллер
        }
        let navController = UINavigationController(rootViewController: createVC)
        present(navController, animated: true)
    }
}

extension PostDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.configure(with: post.images[indexPath.item])
        return cell
    }
}
