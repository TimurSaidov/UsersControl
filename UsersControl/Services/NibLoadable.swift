//
//  NibLoadable.swift
//  UsersControl
//
//  Created by Timur Saidov on 15/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self)) // nib: UINib - объект, содержащий IB nib файлов (xib файлов).
    }
    
    static var name: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self { // Метод, загружающий view из класса (файла .swift, соответствующего объекту xib/nib).
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        
        return view
    }
}
