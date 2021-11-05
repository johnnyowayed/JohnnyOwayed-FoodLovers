//
//  HomeSceneModel.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation

struct HomeSceneModel {
    
    struct Request {
    }
    
    struct Response {
        let reciepes: Receipes
    }
    
    struct ViewModel {
        
        struct Categories {
            let categoryName:String
            let categories: [Items]
        }
        
        struct Items {
            let name: String
            let imageUrl: String
            let timeToPrepare:String
            let smallDescrition:String
            let ingredients: [String]
            let steps: [String]
        }
        
        var viewModelItems: [Categories]
    }
}
