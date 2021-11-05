//
//  HomeSceneViewController.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation
import UIKit

protocol PresenterOutput {
    
}

final class HomeSceneViewController: UIViewController, PresenterOutput {
    var interactor: HomeSceneInteractorImplementation?
    var router: HomeSceneRouterImplementation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.interactor?.fetchFoods()
    }
}

//MARK: - Clean Swift Setup
extension HomeSceneViewController {
    func setup() {
        let viewController = self
        let presenter = HomeScenePresenterImplementation()
        let interactor = HomeSceneInteractorImplementation()
        let router = HomeSceneRouterImplementation()
        let webService = WebServiceServiceRequest()
        viewController.interactor = interactor
        viewController.router = router
        interactor.webService = webService
        interactor.presenter = presenter
        presenter.homeSceneViewController = viewController
    }
}


