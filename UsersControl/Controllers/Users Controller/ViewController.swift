//
//  ViewController.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: Outlets
    
    @IBOutlet weak var loadingStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Public Properties
    
    var users: [User] = []
    var filteredUsers: [User] = []
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    // MARK: Private Properties
    
    private let userParser = ParserFactory.UserParserFactory.userParser()
    private let searchController = UISearchController(searchResultsController: nil)
    private var refreshControl: UIRefreshControl!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupSearchController()
        setupTableView()
        setupRefreshControl()
        fetchUsers()
    }
    
    
    // MARK: Private
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9332318306, green: 0.9333917499, blue: 0.933221817, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Users"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    @objc private func handleAdd() {
        let addNewUserController = AssemblyManager.makeAddNewUserController()
        addNewUserController.insertNewUserDelegate = self
        let navController = UINavigationController(rootViewController: addNewUserController)
        present(navController, animated: true, completion: nil)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UsersTableViewCell.nib, forCellReuseIdentifier: UsersTableViewCell.name)
        tableView.backgroundColor = #colorLiteral(red: 0.9332318306, green: 0.9333917499, blue: 0.933221817, alpha: 1)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        fetchUserInFirstLaunch(false)
    }
    
    private func fetchUsers() {
        fetchUserInFirstLaunch(true)
    }
    
    private func fetchUserInFirstLaunch(_ isFirstLauch: Bool) {
        isFirstLauch ? loadingStackViewIsShown(true) : refreshControl.beginRefreshing()
        NetworkManager.fetchUsers(parser: userParser) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let incomingUsers):
                isFirstLauch ? self.loadingStackViewIsShown(false) : self.refreshControl.endRefreshing()
                self.users = incomingUsers
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .error(let error):
                isFirstLauch ? self.loadingStackViewIsShown(false) : self.refreshControl.endRefreshing()
                let alertController = AlertManager.makeAlertInthernetIsOff(error: error)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func loadingStackViewIsShown(_ isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        loadingStackView.isHidden = !isLoading
    }
}
