//
//  ViewController+InserNewUserDelegate.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

extension ViewController: InserNewUserDelegate {
    
    func inserNewUser(user: User) {
        users.append(user)
        let newIndexPath = IndexPath(row: users.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
