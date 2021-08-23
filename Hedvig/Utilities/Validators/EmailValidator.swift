//
//  EmailValidator.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/23/21.
//

import Foundation

class EmailValidator {
    
    /**
     This is Validates this `email`
     
     # USE
     ```
     let emailValidator = EmailValidator()
     return emailValidator.isEmail(email)
     ```
     */
    func isEmail(_ text: String) -> Bool {
        let text = text
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
