//
//  Result.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}
