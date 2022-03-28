//
//  UIViewController+presentAlert.swift
//  Millionaire
//
//  Created by Anton Hodyna on 28/03/2022.
//

import UIKit

extension UIViewController {

    func presentAlert(withTitle title: String, message : String, callback: (()->Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        callback?()
    }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
