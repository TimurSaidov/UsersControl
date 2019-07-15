//
//  AlertManager.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

class AlertManager {
    
    
    // MARK: Public
    
    static func makeAlertInthernetIsOff(error: String) -> UIAlertController {
        let alertController = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        return alertController
    }
}
