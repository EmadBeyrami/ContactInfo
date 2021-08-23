//
//  KeyboardDismisable.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

protocol KeyboardDismisable {
    func initTapDismisable()
}

extension KeyboardDismisable where Self: UIViewController {
    
    func initTapDismisable() {
        self.configureKeyboardDismissOnTap()
    }
    
}
