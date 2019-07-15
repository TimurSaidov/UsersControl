//
//  UserParser.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    associatedtype Model: Sequence
    func parse(data: Data) -> Model?
}

typealias json = [String: Any]
typealias jsonArray = [[String: Any]]

class UserParser: ParserProtocol {
    
    
    // MARK: Public Properties
    
    typealias Model = [User]
    
    
    // MARK: Public
    
    func parse(data: Data) -> [User]? {
        do {
            guard
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? jsonArray
                else { return nil}
            
            var users: [User] = []
            for json in jsonArray {
                guard let user = User.parse(json: json) else {
                    return nil
                }
                users.append(user)
            }
            return users
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
