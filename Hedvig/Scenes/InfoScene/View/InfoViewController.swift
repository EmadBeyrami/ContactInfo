//
//  InfoViewController.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

class InfoViewController: BaseViewController, Storyboarded {
    
    // MARK: - Coordinator
    weak var coordinator: InfoCoordinator?
    
    // MARK: - ViewModel
    private var infoViewModel: InfoViewModel = InfoViewModel(dataManager: DataManager.shared)
    
    // MARK: - IBOutlets
    // Not using weak IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    private lazy var saveButton: UIBarButtonItem = {
        let saveBtn = UIBarButtonItem(title: LocalizedStrings.save.value, style: .done, target: self, action: #selector(save))
        saveBtn.setAttributed(size: 17)
        return saveBtn
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let cancelBtn = UIBarButtonItem(title: LocalizedStrings.cancel.value, style: .plain, target: self, action: #selector(cancelEditing))
        cancelBtn.setAttributed(size: 17)
        return cancelBtn
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        infoViewModel.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isTransparentNavigationBar()
    }
    
    // MARK: - View
    private func setupView() {
        title = LocalizedStrings.infoTitle.value
        setupTableView()
        isFontedTitle()
        initTapDismisable()
    }
    
    private func changeViewStateTo(isEditing: Bool) {
        navigationItem.leftBarButtonItem  = isEditing ? cancelButton : nil
        navigationItem.rightBarButtonItem = isEditing ? saveButton : nil
    }
    
    private func showDataLossAlert() {
        self.showAlert(title: LocalizedStrings.warning.value,
                       message: LocalizedStrings.dataLossAlert.value,
                       hasCancelBtn: true) { [weak self] _ in
            guard let self = self else { return }
            self.infoViewModel.resetDataInput()
            self.changeViewStateTo(isEditing: false)
        }
    }
    
    // MARK: - Actions
    @objc private func save() {
        self.view.endEditing(true)
        infoViewModel.setData()
    }
    
    @objc private func cancelEditing() {
        self.view.endEditing(true)
        infoViewModel.isInputChanged() ? showDataLossAlert() : changeViewStateTo(isEditing: false)
    }
    
    // MARK: - Binding
    private func setupBinding() {
        
        // subscribe to loading
        infoViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.view.animateActivityIndicator() : self.view.removeActivityIndicator()
        }
        
        // subscribe to fetchData
        infoViewModel.onSuccess = { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        // subscribe to errors
        infoViewModel.onError = { [weak self] message in
            guard let self = self else { return }
            self.showAlert(message: message)
        }
        
        // subscribe to Dataupdate
        infoViewModel.onDataUpdateSucces = { [weak self] in
            guard let self = self else { return }
            self.changeViewStateTo(isEditing: false)
        }
    }

}

// MARK: - UITableView Delegate and DataSource
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(InputCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset.top = 20
        tableView.tableFooterView = tableView.simpleTableViewFooter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoViewModel.getNumberOfrowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        infoViewModel.getTitleFor(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(InputCell.self)
        
        cell.configureCellWith(infoViewModel.getCellData(for: indexPath))
        
        cell.bind { [weak self] model in
            guard let self = self else { return }
            self.infoViewModel.updateTempData(for: indexPath, with: model)
        }
        
        cell.isEditing { [weak self] isEditing in
            guard let self = self else { return }
            self.changeViewStateTo(isEditing: isEditing)
        }
        
        return cell
    }
}
