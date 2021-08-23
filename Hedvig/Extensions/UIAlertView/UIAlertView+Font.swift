//
//  UIAlertView+Font.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit

extension UIAlertController {
    
    func applyAttributedFont() {
        
        applyAlertTitleFont()
        applyAlertMessageFont()
    }
    
    func applyAlertTitleFont(size: CGFloat = 20) {
        let titleFont = [NSAttributedString.Key.font: AppFont.customFont(size: size)]
        let titleAttrString = NSMutableAttributedString(string: title ?? "", attributes: titleFont)
        setValue(titleAttrString, forKey: "attributedTitle")
    }
    
    func applyAlertMessageFont(size: CGFloat = 16) {
        let messageFont = [NSAttributedString.Key.font: AppFont.customFont(size: size)]
        let messageAttrString = NSMutableAttributedString(string: message ?? "", attributes: messageFont)
        setValue(messageAttrString, forKey: "attributedMessage")
    }
    
    func applyNoActionFont(size: CGFloat = 16) {
        let font = [NSAttributedString.Key.font: AppFont.customFont(size: size)]
        for actionButton in actions {
            let titleAttrString = NSMutableAttributedString(string: actionButton.title ?? "", attributes: font)
            actionButton.setValue(titleAttrString, forKey: "attributedTitleForAction")
        }
    }
    
    func applyYesActionFont(size: CGFloat = 16) {
        let font = [NSAttributedString.Key.font: AppFont.customFont(size: size)]
        for actionButton in actions {
            let titleAttrString = NSMutableAttributedString(string: actionButton.title ?? "", attributes: font)
            actionButton.setValue(titleAttrString, forKey: "attributedTitleForAction")
        }
    }
}
