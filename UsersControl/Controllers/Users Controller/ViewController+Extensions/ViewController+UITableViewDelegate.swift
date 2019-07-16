//
//  ViewController+UITableViewDelegate.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let addNewUserController = AssemblyManager.makeAddNewUserController()
        let user = isFiltering ? filteredUsers[indexPath.row] : users[indexPath.row]
        addNewUserController.user = user
        navigationController?.pushViewController(addNewUserController, animated: true)
    }
}
