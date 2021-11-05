//
//  HomeScenePressenter.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation

protocol HomeScenePresenter {
    func interactor(foodFetched: HomeSceneModel.Response)
}

final class HomeScenePresenterImplementation: HomeScenePresenter {
    weak var homeSceneViewController: HomeSceneViewController?
    
    
    func interactor(foodFetched: HomeSceneModel.Response) {
        
        var viewModel: [HomeSceneModel.ViewModel.Categories] = []
        
        for category in foodFetched.reciepes.AllFoods {
            var array_Items: [HomeSceneModel.ViewModel.Items] = []
            
            for item in category.receipes {
                array_Items.append(HomeSceneModel.ViewModel.Items.init(name: item.name, imageUrl: item.imageurl, timeToPrepare: item.timetoprepare, smallDescrition: item.smalldescription, ingredients: item.ingredients, steps: item.steps))
            }
            
            let newCategory = HomeSceneModel.ViewModel.Categories.init(categoryName: category.categoryName, categories: array_Items)
            viewModel.append(newCategory)
        }
        
        self.homeSceneViewController?.presenterOutput(viewModel: viewModel)
    }
}
