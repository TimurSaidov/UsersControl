//
//  User.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatarUrl: String?
    var avatar: Data?
    let createdAt: String
    let updatedAt: String
    let url: String
}
