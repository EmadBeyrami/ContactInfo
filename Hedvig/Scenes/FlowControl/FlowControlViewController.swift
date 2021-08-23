//
//  FlowControlViewController.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

class FlowControlViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    // Not using weak IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var toInfoButton: UIButton!
    @IBOutlet var changeLanguageButton: UIButton!
    @IBOutlet var noteLabel: UILabel!
    
    // MARK: - Coordinator
    weak var coordinator: AppCoordinator?
    
    // MARK: - Properties
    // supported Languages AlertView
    lazy var changeLanguageAlertController: UIAlertController = {
        
        let alert = UIAlertController(title: LocalizedStrings.changeLanguage.value, message: nil, preferredStyle: .actionSheet)
        
        let englishLangAlert = UIAlertAction(title: SupportedLanguages.english.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .english
            self.coordinator?.userChangedLanguage()
        }
        
        let finnishLangAlert = UIAlertAction(title: SupportedLanguages.finnish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .finnish
            self.coordinator?.userChangedLanguage()
        }
        
        let germanLangAlert = UIAlertAction(title: SupportedLanguages.german.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .german
            self.coordinator?.userChangedLanguage()
        }
        
        let swedishLangAlert = UIAlertAction(title: SupportedLanguages.swedish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .swedish
            self.coordinator?.userChangedLanguage()
        }
        
        let danishLangAlert = UIAlertAction(title: SupportedLanguages.danish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .danish
            self.coordinator?.userChangedLanguage()
        }
        
        let NorwegianLangAlert = UIAlertAction(title: SupportedLanguages.norwegian.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LanguageManager.shared.currentLanguage = .norwegian
            self.coordinator?.userChangedLanguage()
        }
        
        let cancelAction = UIAlertAction(title: LocalizedStrings.cancel.value, style: .cancel)
        
        alert.addAction(englishLangAlert)
        alert.addAction(swedishLangAlert)
        alert.addAction(danishLangAlert)
        alert.addAction(NorwegianLangAlert)
        alert.addAction(finnishLangAlert)
        alert.addAction(germanLangAlert)
        alert.addAction(cancelAction)
        alert.applyAttributedFont()
        return alert
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        setupView()
    }
    
    // MARK: - ViewSetup
    func setupView() {
        
        // toInfoButton
        toInfoButton.backgroundColor = .hedvigPurple
        toInfoButton.setTitle(LocalizedStrings.toInfo.value, for: .normal)
        toInfoButton.setTitleColor(.white, for: .normal)
        toInfoButton.setAttributed(size: 15)
        toInfoButton.addTarget(self, action: #selector(toInfo), for: .touchUpInside)
        
        // changeLanguageButton
        changeLanguageButton.backgroundColor = .white
        changeLanguageButton.setTitle(LocalizedStrings.changeLanguage.value, for: .normal)
        changeLanguageButton.setAttributed(size: 15)
        changeLanguageButton.setTitleColor(.hedvigPurple, for: .normal)
        changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        // noteLabel
        noteLabel.textAlignment = .center
        noteLabel.setAttributed(size: 20)
        noteLabel.numberOfLines = 0
        noteLabel.text = LocalizedStrings.controllFlowNotelabel.value + "\n Translation is copied from google translate :)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UINavigationController
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Navigate to Info scene
    @objc func toInfo() {
        coordinator?.toInfo()
    }
    
    // Present Change language AlertVC
    @objc func changeLanguage() {
        self.present(changeLanguageAlertController, animated: true, completion: nil)
    }
}
