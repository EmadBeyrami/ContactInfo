//
//  InputCell.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

typealias inputCellCallbackHandler = DataCompletion<InputCellModel>

class InputCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    
    // MARK: - Properties
    private var textDidChangeCallBack: inputCellCallbackHandler = { _ in }
    private var inputModel: InputCellModel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        inputTextField.text = nil
        inputTextField.placeholder = nil
    }
    
    // MARK: - View Setup
    private func setupView() {
        inputTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        guard let text = inputTextField.text else { return }
        inputModel.value = text
        textDidChangeCallBack(inputModel)
    }
    
    // MARK: - Filler
    private func fill(item: InputCellModel) {
        inputModel = item
        titleLabel.text = item.title
        inputTextField.placeholder = item.placeHolder
    }
    
    // MARK: - Binder
    public func bind(_ completion: @escaping inputCellCallbackHandler) {
        self.textDidChangeCallBack = completion
    }
    
}

// MARK: - TableView Cell Delegate
extension InputCell: HedvigTableViewCell {
    
    func configureCellWith(_ item: InputCellModel) {
        fill(item: item)
    }
    
}
