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
            let response = HomeSceneModel.Response.init(reciepes: receipes)
            self.presenter?.interactor(foodFetched: response)
        }, failure: { errorMessage in
            print()
        })
    }
}
