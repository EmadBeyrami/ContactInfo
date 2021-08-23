//
//  FontExtensions.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

extension UILabel {
    
    func textColor(color: UIColor) {
        self.textColor = color
    }
    
    func setAttributed(size: CGFloat) {
        self.font = AppFont.customFont(size: size)
    }
    
    func textAlignmentLocalized() {
        self.textAlignment = LanguageManager.shared.currentLanguage.textAlignment
    }
    
}

extension UITextField {
    
    func textColor(color: UIColor) {
        self.textColor = color
    }
    
    func setAttributed(size: CGFloat) {
        self.font = AppFont.customFont(size: size)
    }
}

extension UINavigationBar {
    
    func setAttributed(size: CGFloat) {
        self.titleTextAttributes = [NSAttributedString.Key.font: AppFont.customFont(size: 20)]
    }
}

extension UIView {
    var textAlignmentLocalized: NSTextAlignment {
        return LanguageManager.shared.currentLanguage.textAlignment
    }
}

extension UIBarButtonItem {
    func setAttributed(size: CGFloat) {
        setTitleTextAttributes([NSAttributedString.Key.font: AppFont.customFont(size: size)], for: .normal)
    }
}

extension UIButton {
    func setAttributed(size: CGFloat) {
        self.titleLabel?.font = AppFont.customFont(size: size)
    }
}

class AppFont {
    static func customFont(size: CGFloat) -> UIFont {
        var scaledSize = size
        
        if #available(iOS 11, *) {
            scaledSize = UIFontMetrics.default.scaledValue(for: size)
        }
        if let result = UIFont(name: "FavoritStd-Book", size: scaledSize) {
            return result
        }
        return UIFont.systemFont(ofSize: scaledSize)
    }
}
