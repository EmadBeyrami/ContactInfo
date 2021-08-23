//
//  UIView+TapDissmisal.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

extension UIViewController {
    func configureKeyboardDismissOnTap() {
        let keyboardDismissGesture = UITapGestureRecognizer(target: self,
                                                            action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(keyboardDismissGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
