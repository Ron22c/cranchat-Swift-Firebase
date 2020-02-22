//
//  HomeViewController.swift
//  CranChat
//
//  Created by Ranajit Chandra on 20/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: self)

    }

}
