//
//  InfoCoordinator.swift
//  Hedvig
//
//  Created by Emad Bayramy on 8/20/21.
//

import UIKit

class InfoCoordinator: Coordinator {
    
    var rootViewController: UIViewController?
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let infoVC = InfoViewController.instantiate(coordinator: self)
        navigationController.pushViewController(infoVC, animated: animated)
        navigationController.setViewControllers([infoVC], animated: false)
    }
    
    deinit {
        print("Removed \(self) from memory")
    }
    
}
