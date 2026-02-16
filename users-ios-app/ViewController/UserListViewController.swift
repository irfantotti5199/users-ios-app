//
//  ViewController.swift
//  users-ios-app
//
//  Created by Irfan on 16/02/26.
//

import UIKit

class UserListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        
        view.backgroundColor = .white
        setupTableView()
        
        Task {
            await viewModel.fetchInitialUsers()
            tableView.reloadData()
        }
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        
        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > tableView.contentSize.height - scrollView.frame.size.height - 100) {
            Task {
                await viewModel.loadMore()
                tableView.reloadData()
            }
        }
    }
}

