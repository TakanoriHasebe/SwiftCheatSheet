//
//  ViewController.swift
//  SwiftGameofChats
//
//  Created by Takanori.H on 2017/08/05.
//  Copyright © 2017年 Takanori.H. All rights reserved.
//

import UIKit
import Firebase

/* UITableViewControllerに変更することで、TableViewに変更できる */
class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* handleLogout関数を呼び出し */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        /* 画像を右上に配置 */
        let image = UIImage(named: "new_message_icon")
        /* handleNewMessage関数を呼び出し */
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    /* Messanger.swiftを呼び出し */
    func handleNewMessage(){
        
        /* 右上に配置された画像が押されたら、NewMessageController.swiftを呼び出す */
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        
    }
    
    /***************** FirebaseのDatabaseから情報を取得する *****************/
    func checkIfUserIsLoggedIn(){
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                /* 下記のcodeでnavigationItemのタイトルに名前を表示する */
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
                /* Firebaseから取得した情報の全てを表示 */
                // print(snapshot)
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
    }
    /***************** FirebaseのDatabaseから情報を取得する *****************/

    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

