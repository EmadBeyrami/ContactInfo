//
//  UITableView+Register.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/22/21.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
    
}
