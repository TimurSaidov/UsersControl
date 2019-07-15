//
//  NetworkManager.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    static func fetchUsers<Parser: ParserProtocol>(parser: Parser, completionHandler: @escaping (Result<Parser.Model>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    
    // MARK: Private Properties
    
    static private let api = "https://frogogo-test.herokuapp.com"
    
    
    // MARK: Public
    
    static func fetchUsers<Parser>(parser: Parser, completionHandler: @escaping (Result<Parser.Model>) -> Void) where Parser : ParserProtocol {
        let fetchUsersApi = api + "/users.json"
        guard let url = URL(string: fetchUsersApi) else {
            completionHandler(Result.error("URL can't be created from this API: \(fetchUsersApi)"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(Result.error(error.localizedDescription))
                }
                return
            }
            
            guard
                let data = data,
                (response as? HTTPURLResponse)?.statusCode == 200
                else {
                    DispatchQueue.main.async {
                        completionHandler(Result.error("Can't fetch data from URL: \(url)"))
                    }
                    return
            }
            
            guard let usersWithoutAvatars = parser.parse(data: data) else {
                DispatchQueue.main.async {
                    completionHandler(Result.error("Can't parse data"))
                }
                return
            }
            
            // Получение битовых данных аватарки и добавление их в поле user.
            var users: [User] = []
            for user in usersWithoutAvatars {
                guard var user = user as? User else { return }
                if
                    let imageUsersApi = user.avatarUrl,
                    imageUsersApi != String.empty
                {
                    guard let imageUrl = URL(string: imageUsersApi) else {
                        completionHandler(Result.error("URL can't be created from this API: \(imageUsersApi)"))
                        return
                    }
                    
                    do {
                        let imageData = try Data(contentsOf: imageUrl)
                        user.avatar = imageData
                        users.append(user)
                    } catch {
                        print(error.localizedDescription)
                        users.append(user)
                    }
                } else {
                    users.append(user)
                }
            }
            guard let usersWithAvatars = users as? Parser.Model else { return }
            
            DispatchQueue.main.async {
                completionHandler(Result.success(usersWithAvatars))
            }
        }
        task.resume()
    }
}
