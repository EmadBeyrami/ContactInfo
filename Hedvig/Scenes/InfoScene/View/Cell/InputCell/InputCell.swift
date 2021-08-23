//
//  InputCell.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

// MARK: - Public properties
typealias InputCellCallbackHandler = DataCompletion<InputCellModel>

// MARK: - InputTypes
enum CellInputType: String {
    case normal
    case phoneNumber
    case email
    case numeric
    
    var id: Int {
        switch self {
        case .normal:
            return 1
        case .phoneNumber:
            return 2
        case .email:
            return 3
        case .numeric:
            return 4
        }
    }
    
    var inputType: UIKeyboardType {
        switch self {
        case .normal:
            return .default
        case .phoneNumber:
            return .phonePad
        case .email:
            return .emailAddress
        case .numeric:
            return .numberPad
        }
    }
}

class InputCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    
    // MARK: - Properties
    private var textDidChangeCallBack: InputCellCallbackHandler = { _ in }
    private var editingDidBeginCallback: BoolCompletion         = { _ in }
    private var inputModel: InputCellModel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        inputModel = nil
        titleLabel.text = ""
        inputTextField.text = nil
        inputTextField.placeholder = nil
        inputTextField.keyboardType = .default
    }
    
    // MARK: - View Setup
    private func setupView() {
        inputTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        inputTextField.addTarget(self, action: #selector(editBegined), for: .editingDidBegin)
        
        inputTextField.setAttributed(size: 17)
        titleLabel.setAttributed(size: 17)
    }
    
    @objc private func textDidChange() {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        inputModel.value = text
        textDidChangeCallBack(inputModel)
    }
    
    @objc private func editBegined() {
        editingDidBeginCallback(true)
    }
    
    private func localizeTheSaveData(key: String?) -> String {
        return NSLocalizedString(key ?? LocalizedStrings.error.rawValue, comment: "")
    }
    
    // MARK: - Filler
    private func fill(item: InputCellModel) {
        inputModel = item
        titleLabel.text = localizeTheSaveData(key: item.title)
        inputTextField.placeholder = localizeTheSaveData(key: item.placeHolder)
        inputTextField.text = localizeTheSaveData(key: item.value)
        inputTextField.keyboardType = item.getInputType().inputType
    }
    
    // MARK: - Binder
    public func bind(_ completion: @escaping InputCellCallbackHandler) {
        self.textDidChangeCallBack = completion
    }
    
    public func isEditing(_ completion: @escaping BoolCompletion) {
        self.editingDidBeginCallback = completion
    }
    
    public func configureCellWith(_ item: InputCellModel) {
        fill(item: item)
    }
    
}
