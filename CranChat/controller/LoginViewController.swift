//
//  LoginViewController.swift
//  CranChat
//
//  Created by Ranajit Chandra on 20/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController{

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
//        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error == nil {
                print("LoggedIn")
//                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "loginToChat", sender: self)
            } else {
                print(error!)
            }
        }
    }
}
