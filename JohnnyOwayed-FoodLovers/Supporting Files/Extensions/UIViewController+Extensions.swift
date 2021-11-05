//
//  UIViewController+Extensions.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(message: String, title: String = "", yesAction: @escaping ()->Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "Yes", style: .default) { _ in
            yesAction()
        }
        let no = UIAlertAction.init(title: "No", style: .default) { _ in
            
        }
        alertController.addAction(yes)
        alertController.addAction(no)
        self.present(alertController, animated: true, completion: nil)
      }
}
