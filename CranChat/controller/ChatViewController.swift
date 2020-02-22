//
//  ChatViewController.swift
//  CranChat
//
//  Created by Ranajit Chandra on 20/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var messageArray : [MessageModel] = [MessageModel]()
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        retriveMessage()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        messageTextField.isEnabled = false
        let messagesDB = Database.database().reference().child("Messages")
        let messageDict = ["sender": Auth.auth().currentUser?.email, "messageBody": messageTextField.text]
        messagesDB.childByAutoId().setValue(messageDict) {
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("message sent successfully!!")
                self.messageTextField.isEnabled = true
                self.messageTextField.text = ""
            }
        }
    }
    
    @IBAction func signoutButton(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("There is a problem with sign out")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! TableViewCell
        cell.messageBody.text = self.messageArray[indexPath.row].messageBody
        cell.senderUsername.text = self.messageArray[indexPath.row].sender
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email{
            cell.messageBackground.backgroundColor = UIColor.flatMint()
            cell.avatarImageView.backgroundColor = UIColor.flatYellow()
        } else {
            cell.messageBackground.backgroundColor = UIColor.flatLime()
            cell.avatarImageView.backgroundColor = UIColor.flatSkyBlue()
        }
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        heightConstraint.constant = 308
//        view.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func retriveMessage() {
        let messageDb = Database.database().reference().child("Messages")
        messageDb.observe(.childAdded) {
            (snapshot) in
            let snap =  snapshot.value as! Dictionary<String,String>
            let text = snap["messageBody"]
            let sender = snap["sender"]
            
            let message = MessageModel()
            message.messageBody = text!
            message.sender = sender!
            
            self.messageArray.append(message)
            self.tableView.reloadData()
        }
    }
}
