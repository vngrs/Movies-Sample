//
//  BaseViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

import UIKit

class BaseViewController: UIViewController {


}

// MARK: - Show Error Extension

extension BaseViewController {

    func showError(
        title: String = "Oops",
        message: String = "Something went wrong, please try again later",
        actionTitle: String = "Okay",
        handler: (() -> Void)? = nil
        ) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) { _ in

            handler?()
        })

        present(alert, animated: true, completion: nil)
    }

    func showAlert(
        title: String = "Success",
        message: String,
        actionTitle: String = "Ok",
        handler: (() -> Void)? = nil
        ) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) { _ in

            handler?()
        })

        present(alert, animated: true, completion: nil)
    }
}
