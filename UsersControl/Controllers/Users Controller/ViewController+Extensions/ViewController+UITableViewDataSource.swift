//
//  ViewController+UITableViewDataSource.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    
    
    // MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.name, for: indexPath) as! UsersTableViewCell
        let user = isFiltering ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        drawFullSeparator(cell: cell,
                          row: indexPath.row,
                          usersCount: users.count)
        return cell
    }
    
    
    // MARK: Private
    
    private func drawFullSeparator(cell: UsersTableViewCell, row: Int, usersCount: Int) {
        if row == usersCount - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
