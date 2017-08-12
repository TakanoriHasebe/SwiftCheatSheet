//
//  NewMessageController.swift
//  SwiftGameofChats
//
//  Created by Takanori.H on 2017/08/12.
//  Copyright © 2017年 Takanori.H. All rights reserved.
//

/*
 〇: 参考になったプログラムの書き方
 ①: Firebaseから情報を取得する
 */

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "cellId"
    
    /* ユーザー情報を保存する配列 */
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 左上にtitleを配置 〇 */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        /* tableViewに表示 〇 */
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        /* users情報の取得 〇 ① */
        fetchUser()
        
    }
    
    /* コピペ */
    /* Userの情報を取得 ① */
    func fetchUser(){
        /* コピペ */
        /* Firebaseから全てのユーザー情報を取得 */
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                /* Firebaseから取得したユーザー */
                /* if you use this setter, your app will clash if your class properties don't exactly match up with the firebase dictionary keys */
                let user = Users()
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
                
                /* ユーザーの名前とユーザーのemailを表示 */
                // user.name = dictionary["name"] as! String
                // print(user.name, user.email)
            }
            
            /* 取得した全てのユーザーを表示する */
            // print("User Found")
            // print(snapshot)
            
        }, withCancel: nil)
        
    }
    
    
    /* 左上のCancelが押された時に実行 〇 ① */
    func handleCancel(){
        
        /* ひとつ前のViewに戻る 〇 */
        dismiss(animated: true, completion: nil)
    }
    
    /* 表示するテキストの個数 〇 ① */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    /* tableViewにテキストを表示 〇 ① */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        /* 下のcodeでtableViewにユーザー名, emailを表示 */
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
}

/* User情報を表示 */
class UserCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
