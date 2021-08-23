//
//  UserDefaultsConfig.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import Foundation

struct UserDefaultsConfig {
    
    enum UserDefaultsKey: String {
        case appleLanguages  = "AppleLanguages"
        case currentLanguage
        case userInfo
        
        var defaultValue: Any {
            switch self {
            case .appleLanguages:
                return UserDefaultsConfig.appleLanguage
            case .currentLanguage:
                return UserDefaultsConfig.currentLanguage
            case .userInfo:
                let phone = InputCellModel(id: 1,
                                           title: LocalizedStrings.phoneNumber.rawValue,
                                           placeHolder: "07xxx",
                                           value: "",
                                           inputType: CellInputType.phoneNumber.id)
                let email = InputCellModel(id: 2,
                                           title: LocalizedStrings.email.rawValue,
                                           placeHolder: "someone@email.com",
                                           value: "",
                                           inputType: CellInputType.email.id)
                let model = [InputSectionModel(sectionTitle: LocalizedStrings.contactDetails.rawValue, items: [phone, email])]
                return model
            }
        }
    }
    
    @UserDefault(.currentLanguage, defaultValue: "en")
    static var currentLanguage: String
    
    @UserDefault(.appleLanguages, defaultValue: ["en"])
    static var appleLanguage: [String]
    
    @UserDefault(.userInfo, defaultValue: UserDefaultsConfig.UserDefaultsKey.userInfo.defaultValue as! InputSectionArrayModel)
    static var userInfo: InputSectionArrayModel
    
    static func clearUserDefaultFor(_ key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func clearAllUserDefault() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
    }
}
