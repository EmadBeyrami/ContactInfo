//
//  UITableView+DequeueCell.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/22/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type) -> T {
        self.dequeueReusableCell(withIdentifier: String(describing: cell)) as! T
    }
    
}
