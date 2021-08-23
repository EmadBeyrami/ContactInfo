//
//  BaseViewController.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import UIKit
typealias AlertAction = ((UIAlertAction) -> Void)
class BaseViewController: UIViewController {
    
    // MARK: - public funcs
    func isTransparentNavigationBar(_ transparent: Bool = true) {
        self.navigationController?.isTransparentNavigationBar(transparent)
    }
    
    func isFontedTitle(size: CGFloat = 20) {
        self.navigationController?.fontedTitle(size: size)
    }
    
    func showAlert(title: String = LocalizedStrings.error.value,
                   message: String = "",
                   actionBtnTitle: String = LocalizedStrings.ok.value,
                   hasCancelBtn: Bool = false,
                   cancelBtnTitle: String = LocalizedStrings.cancel.value,
                   actionHandler: AlertAction? = nil) {
        
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        let actionBtn = UIAlertAction(title: actionBtnTitle, style: .default, handler: actionHandler)
        ac.addAction(actionBtn)
        if hasCancelBtn {
            ac.addAction(UIAlertAction(title: cancelBtnTitle, style: .cancel, handler: nil))
        }
        ac.applyAttributedFont()
        self.present(ac, animated: true, completion: nil)
    }
    
}
