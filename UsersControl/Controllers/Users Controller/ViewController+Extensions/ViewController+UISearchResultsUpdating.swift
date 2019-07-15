//
//  ViewController+UISearchResultsUpdating.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

extension ViewController: UISearchResultsUpdating {
    
    
    // MARK: Search results updating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearch(searchText)
    }
    
    
    // MARK: Private
    
    private func filterContentForSearch(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({ user -> Bool in
            return user.firstName.lowercased().contains(searchText.lowercased()) || user.lastName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
