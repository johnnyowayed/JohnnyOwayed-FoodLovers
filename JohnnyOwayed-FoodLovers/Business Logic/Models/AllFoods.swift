//
//  AllFoods.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation

struct Receipes:Decodable {
    let AllFoods:[AllFood]
}

struct AllFood: Decodable {
    let categoryName:String
    let receipes: [Receipe]
}

struct Receipe:Decodable {
    let name:String
    let imageurl:String
    let timetoprepare:String
    let smalldescription:String
    let ingredients: [String]
    let steps: [String]
}
