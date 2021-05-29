//
//  AlertController.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 29.05.2021.
//

import UIKit

 enum AlertControllerConstants {
  static let mostPopularAction = "Most Popular"
  static let mostCommentedAction = "Most Commented"
  static let createdAtAction = "Created At"
  static let cancelAction = "Cancel"
  static let alertControllerTitle = "Posts Filtration"
  static let alertControllerMessage = "Choose the filtration category"
}

struct AlertController {
  
  private static func showFilterButtonAlert(on vc: UIViewController, with title: String, message: String) {
    
    let alertController = UIAlertController (
      title: title,
      message: message,
      preferredStyle: .alert
    )
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.mostPopularAction, style: .default, handler: nil
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.mostCommentedAction, style: .default, handler: nil
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.createdAtAction, style: .default, handler: nil
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.cancelAction, style: .destructive, handler: nil
    ))
    
    DispatchQueue.main.async {
      vc.present(alertController, animated: true)
    }
  }
  
  static func showFiltrationAlertForm(on vc: UIViewController) {
    showFilterButtonAlert(
      on: vc,
      with: AlertControllerConstants.alertControllerTitle,
      message: AlertControllerConstants.alertControllerMessage
    )
  }
  
}
