//
//  AddNewUserViewController.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

class AddNewUserViewController: UIViewController {

    
    // MARK: Outlets
    
    @IBOutlet weak var darkBlueBackgroundView: UIView!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
    
    // MARK: Public Properties
    
    var user: User? {
        didSet {
            print("user: \(String(describing: user?.firstName)) \(String(describing: user?.lastName))")
        }
    }
    
    
    // MARK: Public Properties
    
    weak var insertNewUserDelegate: InserNewUserDelegate?
    
    
    // MARK: Private Properties
    
    private var firstNameText: String?
    private var lastNameText: String?
    private var emailText: String?
    
    
    // MARK: Actions
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if sender.tag == 0 {
            firstNameText = sender.text
        } else if sender.tag == 1 {
            lastNameText = sender.text
        } else if sender.tag == 2 {
            emailText = sender.text
        }
        if
            let firstName = firstNameText,
            let lastName = lastNameText,
            let email = emailText,
            firstName != String.empty,
            firstName != String.space,
            lastName != String.empty,
            lastName != String.space,
            email != String.empty,
            email != String.space,
            email.contains(String.dog)
        {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupView()
        hideKeyboard()
    }
    
    deinit {
        print("\(#function) AddNewUserViewController")
    }
    
    
    // MARK: Private
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .black
        if user == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard
            let firstName = firstNameText,
            let lastName = lastNameText,
            let email = emailText
            else { return }
        let newUser = User(id: nil,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        avatarUrl: nil,
                        avatar: nil,
                        createdAt: nil,
                        updatedAt: nil,
                        url: nil)
        NetworkManager.postNewUser(user: newUser) { [weak self] result in
            self?.dismiss(animated: true, completion: { [weak self] in
                self?.insertNewUserDelegate?.inserNewUser(user: newUser)
            })
        }
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9332318306, green: 0.9333917499, blue: 0.933221817, alpha: 1)
        darkBlueBackgroundView.backgroundColor = UIColor.darkBlue
        setupTextFieldsDelegate()
        setupTextFields()
    }
    
    private func setupTextFieldsDelegate() {
        userFirstNameTextField.delegate = self
        userLastNameTextField.delegate = self
        userEmailTextField.delegate = self
    }
    
    private func setupTextFields() {
        if user != nil {
            userFirstNameTextField.text = user?.firstName
            userLastNameTextField.text = user?.lastName
            userEmailTextField.text = user?.email
        }
    }
    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
