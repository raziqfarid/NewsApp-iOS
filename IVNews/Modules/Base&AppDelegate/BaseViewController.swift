//
//  BaseViewController.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    
    /// Adds the activity indicator
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
    }
    
    /// Shows the loader with animation
    func showLoader() {
        view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    /// Hides the loader
    func hideLoader() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    /// Shows Alert Message with the action "OK" and returns completion handler when action is clicked
    /// - Parameters:
    ///   - title: title of the alert, defaults to "Alert"
    ///   - message: subheading of the alert
    ///   - actionClicked: Returns completion handler when action "OK" is clicked, defaults to nil
    func showAlertMessage(title: String = "Alert", message: String, actionClicked: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: actionClicked))
        self.present(alertController, animated: true, completion: nil)
    }
}
