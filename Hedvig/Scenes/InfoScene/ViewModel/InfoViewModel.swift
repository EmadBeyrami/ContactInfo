//
//  InfoViewModel.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/22/21.
//

import Foundation

class InfoViewModel {
    
    // MARK: - Initializer
    var dataManager: DataManagable
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    // MARK: - publishers
    var onSuccess: DataCompletion<InputSectionArrayModel>?
    var onDataUpdateSucces: Completion?
    var onError: StringCompletion?
    var loading: BoolCompletion?
    
    // MARK: - Properties
    var currentData: InputSectionArrayModel?
    var tempData: InputSectionArrayModel?
    
    // MARK: - View Helpers
    func getNumberOfrowsIn(_ section: Int) -> Int {
        currentData?[section].items.count ?? 1
    }
    
    func getTitleFor(_ section: Int) -> String? {
        let titleKey = currentData?[section].sectionTitle
        return NSLocalizedString(titleKey ?? LocalizedStrings.error.value, comment: "")
    }
    
    func updateTempData(for indexPath: IndexPath, with data: InputCellModel) {
        tempData?[indexPath.section].items[indexPath.row] = data
    }
    
    func getCellData(for indexPath: IndexPath) -> InputCellModel {
        (tempData?[indexPath.section].items[indexPath.row])!
    }
    
    func isInputChanged() -> Bool {
        return tempData != currentData
    }
    
    // MARK: - Validators
    private func isValidInput() -> Bool {
        
        if currentData == tempData {
            onError?(LocalizedStrings.sameDataError.value)
            return false
        }
        
        if !isValidEmail() && !isValidNumber() {
            onError?(LocalizedStrings.emailPhoneError.value)
            return false
        }
        
        guard isValidEmail() else {
            onError?(LocalizedStrings.emailError.value)
            return false
        }
        
        guard isValidNumber() else {
            onError?(LocalizedStrings.phoneError.value)
            return false
        }
        return true
    }
    
    private func isValidEmail() -> Bool {
        guard let emailField = findField(for: .email),
              let email = emailField.value, !email.isEmpty else {
            return false
        }
        
        let emailValidator = EmailValidator()
        return emailValidator.isEmail(email)
    }
    
    private func findField(for inputType: CellInputType) -> InputCellModel? {
        var field: InputCellModel?
        tempData?.forEach({ model in
            field = model.items.first(where: {$0.inputType == inputType.id})
        })
        return field
    }
    
    private func isValidNumber() -> Bool {
        guard let phoneField = findField(for: .phoneNumber),
              let phone = phoneField.value, !phone.isEmpty else {
            return false
        }
        
        let numberValidator = PhoneValidator()
        return numberValidator.isMobileNumber(phone)
    }
    
    // MARK: - dataProvider
    func getData() {
        defer { loading?(false) }
        loading?(true)
        do {
            let initialData = try dataManager.read(key: UserDefaultsConfig.UserDefaultsKey.userInfo) as InputSectionArrayModel
            currentData = initialData
            tempData = initialData
            onSuccess?(initialData)
        } catch {
            onError?(error.localizedDescription)
        }
    }
    
    func setData() {
        defer { loading?(false) }
        loading?(true)
        if !isValidInput() { return }
        do {
            try dataManager.write(key: .userInfo, value: tempData)
            onDataUpdateSucces?()
        } catch {
            onError?(error.localizedDescription)
        }
    }
    
    func resetDataInput() {
        tempData = currentData
        onSuccess?(tempData!)
    }

}
