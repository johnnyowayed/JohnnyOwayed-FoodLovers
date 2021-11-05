//
//  HomeSceneRouter.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation
import UIKit

protocol HomeSceneRouter {
    func goToReceipeDetails(item: ReceipeSceneModel)
}

final class HomeSceneRouterImplementation: HomeSceneRouter {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
}

extension HomeSceneRouterImplementation {
    func goToReceipeDetails(item: ReceipeSceneModel) {
        let storyboard = UIStoryboard(name:"ReceipeDetailsSceneView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReciepeSceneViewController") as! ReciepeSceneViewController
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
