//
//  WebService.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation

protocol WebService {
    func fetchRecipes(success: @escaping (Receipes)-> Void, failure: @escaping (_ errorMessage:String)->Void)
}

final class WebServiceServiceRequest: WebService {
    
    func fetchRecipes(success: @escaping (Receipes) -> Void, failure: @escaping (_ errorMessage:String) -> Void) {
        
        let session = URLSession.shared
        let url = URL(string: "http://testtask.solidtechapps.com/api/v1/response/")!
        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                failure("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                failure("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                failure("Wrong MIME type!")
                return
            }
            let receipes = try! JSONDecoder().decode(Receipes.self, from: data!)
            success(receipes)
        }
        
        task.resume()
    }

}
