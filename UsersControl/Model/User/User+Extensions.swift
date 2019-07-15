//
//  User+Extensions.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

extension User {
    
    
    // MARK: Public Properties
    
    var json: [String: Any] {
        var dict = [String: Any]()
        dict["first_name"] = self.firstName
        dict["last_name"] = self.lastName
        dict["email"] = self.email
        if let id = self.id {
            dict["id"] = id
        } else {
            dict["id"] = nil
        }
        if let avatarUrl = self.avatarUrl {
            dict["avatar_url"] = avatarUrl
        } else {
            dict["avatar_url"] = nil
        }
        if let createdAt = self.createdAt {
            dict["created_at"] = createdAt
        } else {
            dict["created_at"] = nil
        }
        if let updatedAt = self.updatedAt {
            dict["updated_at"] = updatedAt
        } else {
            dict["updated_at"] = nil
        }
        if let url = self.url {
            dict["url"] = url
        } else {
            dict["url"] = nil
        }
        return dict
    }
    
    
    // MARK: Public
    
    static func parse(json: json) -> User? {
        guard
            let firstName = json["first_name"] as? String,
            let lastName = json["last_name"] as? String,
            let email = json["email"] as? String
            else { return nil}
        let id = json["id"] as? Int
        let avatarUrl = json["avatar_url"] as? String
        let createdAt = json["created_at"] as? String
        let updatedAt = json["updated_at"] as? String
        let url = json["url"] as? String
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
