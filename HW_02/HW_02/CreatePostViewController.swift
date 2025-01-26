//
//  CreatePostViewController.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import UIKit

final class CreatePostViewController: UIViewController {
    var onPostCreated: ((Post) -> Void)?
    private var images: [UIImage] = []
    var postToEdit: Post? // Добавляем свойство для редактируемого поста

    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 80, height: 80)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        
        // Если мы редактируем существующий пост, заполняем его данные
        if let post = postToEdit {
            textView.text = post.text
            images = post.images // Заполняем массив изображений
            collectionView.reloadData() // Обновляем коллекцию
            title = "Edit Post" // Изменяем заголовок на "Edit Post"
        }
    }
    
    private func setupNavigationBar() {
        title = "Create Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(savePost)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancel)
        )
    }
    
    private func setupViews() {
        view.addSubview(textView)
        view.addSubview(collectionView)
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        textView.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc private func savePost() {
        guard let text = textView.text, !text.isEmpty || !images.isEmpty else {
            showAlert(title: "Error", message: "Post must contain either text or images.")
            return
        }
        
        // Если редактируем существующий пост, обновляем его данные
        let newPost: Post
        if let existingPost = postToEdit {
            newPost = Post(
                id: existingPost.id, // Используем тот же ID для редактирования
                text: text.isEmpty ? nil : text,
                images: images,
                date: existingPost.date // Дата остается прежней
            )
        } else {
            newPost = Post(
                id: UUID(),
                text: text.isEmpty ? nil : text,
                images: images,
                date: Date()
            )
        }
        
        onPostCreated?(newPost)
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension CreatePostViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count < 4 ? images.count + 1 : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            cell.configure(with: images[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
            cell.configureAsAddButton()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == images.count {
            presentImagePicker()
        } else {
            images.remove(at: indexPath.item)
            collectionView.reloadData()
        }
    }
}


extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentImagePicker() {
        guard images.count < 4 else { return }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            images.append(image)
            collectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
