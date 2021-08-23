//
//  UIColor+Extensions.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

extension UIColor {
    
    private enum CustomColor: String {
        
        case hedvigPurple
        
        var color: UIColor {
            guard let color = UIColor(named: rawValue) else {
                assertionFailure("Color missing from asset catalogue")
                return .systemOrange
            }
            return color
        }
    }
    
    static var hedvigPurple: UIColor = {
        CustomColor.hedvigPurple.color
    }()
}
