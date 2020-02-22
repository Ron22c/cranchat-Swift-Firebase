//
//  RegisterViewController.swift
//  CranChat
//
//  Created by Ranajit Chandra on 20/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 
//        CLOSURE:
//        func calcuate ( a:Int, b:Int, op: (Int, Int)->Int ) -> Int{
//            return op(a,b)
//        }
//        let result = calcuate(a: 23, b: 56){$0*$1}
//        let result2 = calcuate(a: 56, b: 78, op: {
//            (no1:Int, no2:Int) -> Int in
//            return no1 / no2
//        })

    }
    
    @IBAction func registerButton(_ sender: UIButton) {
//        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
            (result, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration successful!")
//                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "registerToChat", sender: self)
            }
        })
    }
    

}
