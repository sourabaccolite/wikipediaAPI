//
//  SuperViewController.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -alert methods
    func showAlert(withTitle alertTitle: String, alertMessage: String, actionTitle: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
