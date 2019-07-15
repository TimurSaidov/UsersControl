//
//  ParserFactory.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation

struct ParserFactory {
    struct UserParserFactory {
        static func userParser() -> UserParser {
            return UserParser()
        }
    }
}
