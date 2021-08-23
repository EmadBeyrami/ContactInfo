//
//  HedvigBarButtonItem.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

class HedvigBarButtonItem: UIBarButtonItem {
    convenience init attributedInit(title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?) {
        self.target = target as AnyObject?
        self.action = action
        self.title = title
        self.style = style
        self.setAttributed(size: 17)
    }
}
