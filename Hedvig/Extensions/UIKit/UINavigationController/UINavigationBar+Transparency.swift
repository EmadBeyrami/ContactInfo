//
//  UINavigationBar+Transparency.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

extension UINavigationController {
    func isTransparentNavigationBar(_ isTrue: Bool = true) {
        self.setNavigationBarHidden(false, animated: true)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
    func fontedTitle(size: CGFloat = 20) {
        self.navigationBar.setAttributed(size: size)
    }
}
