//
//  Room1ViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/29.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class Room1ViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    var number : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "入室しました")

    }
    //退室ボタン
    @IBAction func outButton(_ sender: Any) {
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    //送信ボタン
    @IBAction func sentButton(_ sender: Any) {
        
        // postDataに必要な情報を取得しておく
        let name = Auth.auth().currentUser?.displayName
        

        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child("Room1")
        let postDic = ["comment": commentTextField.text! , "name": name!]
        postRef.childByAutoId().setValue(postDic)
        
    }
    
    
}
