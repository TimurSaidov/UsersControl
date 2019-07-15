//
//  UsersTableViewCell.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell, NibLoadable {

    
    // MARK: Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    // MARK: Public Properties
    
    var user: User? {
        didSet {
            guard
                let firstName = user?.firstName,
                let lastName = user?.lastName,
                let email = user?.email
                else { return }
            userNameLabel.text = "\(firstName) \(lastName)"
            userEmailLabel.text = email
            if let imageData = user?.avatar {
                userImageView.image = UIImage(data: imageData)
            } else {
                userImageView.backgroundColor = .white
                userImageView.image = #imageLiteral(resourceName: "userPhoto")
            }
        }
    }
    
    
    // MARK: Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
    }
    
    
    // MARK: Private
    
    private func setupCellView() {
        backgroundColor = UIColor.darkBlue
        clipsImageView()
        setTextColorInLabels()
    }
    
    private func clipsImageView() {
        userImageView.layer.cornerRadius = 25
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setTextColorInLabels() {
        userNameLabel.textColor = .white
    }
}
