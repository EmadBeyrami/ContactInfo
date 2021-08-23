//
//  LocalizedStrings.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import Foundation

// We can also using swiftgen for generating string files
enum LocalizedStrings: String {
    
    case toProducts = "to_Info"
    case changeLanguage = "Change_Language"
    case controllFlowNotelabel
    case contactDetails
    case infoTitle
    case save
    case email
    case phoneNumber
    case ok
    case cancel
    case warning
    case error
    case dataLossAlert
    case sameDataError
    case emailPhoneError
    case emailError
    case phoneError

    var value: String {
        return localized(key: self.rawValue)
    }
    
    private func localized(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
