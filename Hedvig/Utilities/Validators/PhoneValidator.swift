//
//  PhoneValidator.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import Foundation

class PhoneValidator {
    
    /**
     This is Validates this `Mobile Number`
     
     # USE
     ```
     let mobileValidator = IranianMobileNumberValidator()
     return mobileValidator.isMobileNumber(mobile)
     ```
     */
    func isMobileNumber(_ text: String) -> Bool {
        let mobileRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        let result =  phoneTest.evaluate(with: text)
        return result
    }
}
