//
//  LanguageManager.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import Foundation
import UIKit

enum SupportedLanguages: Int, CaseIterable {
    case english
    case german
    case finnish
    case swedish
    case danish
    case norwegian
    
    var languageDirection: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .german:
            return .ltr
        case .finnish:
            return .ltr
        case .swedish:
            return .ltr
        case .danish:
            return .ltr
        case .norwegian:
            return .ltr
        }
    }
}

@objc enum LanguageDirection: Int {
    case rtl
    case ltr
}

protocol LanguageManagerProtocol {
    var currentLanguage: SupportedLanguages { get set }
    var allSupportedLanguages: [SupportedLanguages] { get }
}

class LanguageManager: LanguageManagerProtocol {
    
    // MARK: - Properties
    static let shared: LanguageManager = LanguageManager()
    
    var allSupportedLanguages: [SupportedLanguages] = SupportedLanguages.allCases
    var currentLanguage: SupportedLanguages {
        get {
            let identifier = UserDefaultsConfig.currentLanguage
            return SupportedLanguages(identifier: identifier)
        }
        set {
            UserDefaultsConfig.currentLanguage = newValue.identifier
            UIView.appearance().semanticContentAttribute = newValue.direction.semantic
            Bundle.setLanguage(newValue.identifier)
        }
    }
    
    var languagecalendar: Calendar {
        let locale = Locale(identifier: currentLanguage.locale)
        return locale.calendar
    }
    // MARK: - Methods
    private init() {}
    
    class func isAValidLanguageIdentifier(_ identifier: String) -> Bool {
        for language in shared.allSupportedLanguages where language.identifier == identifier {
            return true
        }
        return false
    }
}

extension SupportedLanguages {
    var text: String {
        switch self {
        case .english:
            return "English"
        case .finnish:
            return "Suomi"
        case .german:
            return "Deutsch"
        case .swedish:
            return "Swedish"
        case .danish:
            return "Danish"
        case .norwegian:
            return "Norwegian"
        }
    }
    
    var identifier: String {
        switch self {
        case .english:
            return "en-US"
        case .finnish:
            return "fi"
        case .german:
            return "de"
        case .swedish:
            return "sv"
        case .danish:
            return "da"
        case .norwegian:
            return "no"
        }
    }
    
    var direction: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .finnish:
            return .ltr
        case .german:
            return .ltr
        case .swedish:
            return .ltr
        case .danish:
            return .ltr
        case .norwegian:
            return .ltr
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .finnish:
            return .left
        case .german:
            return .left
        case .swedish:
            return .left
        case .danish:
            return .left
        case .norwegian:
            return .left
        }
    }
    
    var oppositeTextAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .finnish:
            return .left
        case .german:
            return .left
        case .swedish:
            return .left
        case .danish:
            return .left
        case .norwegian:
            return .left
        }
    }
    
    var locale: String {
        switch self {
        case .english:
            return "en"
        case .finnish:
            return "fi"
        case .german:
            return "de"
        case .swedish:
            return "sv"
        case .danish:
            return "da"
        case .norwegian:
            return "no"
        }
    }
    
    init(identifier: String?) {
        switch identifier ?? "en-US" {
        case "en-US":
            self = .english
        case "fi":
            self = .finnish
        case "de":
            self = .german
        case "sv":
            self = .swedish
        case "da":
            self = .danish
        case "no" :
            self = .norwegian
        default:
            self = .english
        }
    }
}

extension LanguageDirection {
    var semantic: UISemanticContentAttribute {
        switch self {
        case .ltr:
            return .forceLeftToRight
        case .rtl:
            return .forceRightToLeft
        }
    }
}
