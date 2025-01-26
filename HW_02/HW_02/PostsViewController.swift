//
//  PostsViewController.swift
//  HW_02
//
//  Created by Сабиров Мльнур Марсович on 25.12.2024.
//

import UIKit

final class PostsViewController: UIViewController {
    private enum Section { case main }
    private var posts: [Post] = []
    private var dataSource: UITableViewDiffableDataSource<Section, Post>!

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        configureDataSource()
    }

    private func setupNavigationBar() {
        title = "Moments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addPostTapped)
        )
    }

    private func setupTableView() {
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Post>(tableView: tableView) { tableView, indexPath, post in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
                return UITableViewCell()
            }
            cell.configure(with: post)
            return cell
        }
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc private func addPostTapped() {
        let createVC = CreatePostViewController()
        createVC.onPostCreated = { [weak self] newPost in
            guard let self = self else { return }
            self.posts.append(newPost)
            self.applySnapshot()
        }
        let navController = UINavigationController(rootViewController: createVC)
        present(navController, animated: true)
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailsVC = PostDetailsViewController(post: post)

        // Обновление поста через замыкание
        detailsVC.onPostUpdated = { [weak self] updatedPost in
            guard let self = self else { return }
            if let index = self.posts.firstIndex(where: { $0.id == updatedPost.id }) {
                self.posts[index] = updatedPost
                self.applySnapshot() // Перестраиваем таблицу с обновленным постом
            }
        }
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
