//
//  HomeSceneInteractor.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation

protocol HomeSceneInteractor {
    func fetchFoods()
}

final class HomeSceneInteractorImplementation: HomeSceneInteractor {
    var presenter: HomeScenePresenterImplementation?
    var webService: WebServiceServiceRequest?
    
    func fetchFoods() {
        self.webService?.fetchRecipes(success: { receipes in
            
        }, failure: { errorMessage in
            self.presenter
        })
    }
}
