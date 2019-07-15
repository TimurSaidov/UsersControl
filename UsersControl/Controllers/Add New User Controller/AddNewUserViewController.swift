//
//  AddNewUserViewController.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

class AddNewUserViewController: UIViewController {

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupView()
    }
    
    deinit {
        print("\(#function) AddNewUserViewController")
    }
    
    
    // MARK: Private
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(hanldeCancel))
    }
    
    @objc private func hanldeCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9332318306, green: 0.9333917499, blue: 0.933221817, alpha: 1)
    }
}
