//
//  ViewController.swift
//  SwiftGameofChats
//
//  Created by Takanori.H on 2017/08/05.
//  Copyright © 2017年 Takanori.H. All rights reserved.
//

import UIKit

/* UITableViewControllerに変更することで、TableViewに変更できる */
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* TableViewの左上にNavigationItemを設置 */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
    }

    func handleLogout(){
        
        /* LoginController.swiftから読み込み */
        let loginController = LoginController()
        /* loginControllerに移動 */
        present(loginController, animated: true, completion: nil)
        
    }
    
    
}

