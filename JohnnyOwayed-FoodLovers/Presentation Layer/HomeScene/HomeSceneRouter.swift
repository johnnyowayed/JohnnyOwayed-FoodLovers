//
//  HomeSceneRouter.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation
import UIKit

protocol HomeSceneRouter {
    
}

final class HomeSceneRouterImplementation: HomeSceneRouter {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
}
