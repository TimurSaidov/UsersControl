//
//  User+Extensions.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

extension User {
    
    
    // MARK: Public
    
    static func parse(json: json) -> User? {
        guard
            let id = json["id"] as? Int,
            let firstName = json["first_name"] as? String,
            let lastName = json["last_name"] as? String,
            let email = json["email"] as? String,
            let createdAt = json["created_at"] as? String,
            let updatedAt = json["updated_at"] as? String,
            let url = json["url"] as? String
            else { return nil}
        let avatarUrl = json["avatar_url"] as? String
        let user = User(id: id,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        avatarUrl: avatarUrl,
                        avatar: nil,
                        createdAt: createdAt,
                        updatedAt: updatedAt,
                        url: url)
        return user
    }
}
