//
//  loginViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/24.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    
    @IBOutlet weak var mailAddress: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //ログインボタンタップ時
    @IBAction func handleLoginButton(_ sender: Any) {
        
        if let address = mailAddress.text, let password = password.text {
            
            // アドレスとパスワード名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || password.isEmpty {
                return
            }
            
            Auth.auth().signIn(withEmail: address, password: password) { user, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ログインに成功しました。")
                
                // 画面を閉じてViewControllerに戻る
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    //アカウント作成ボタンタップ時
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        
        if let address = mailAddress.text, let password = password.text {
            
            // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || password.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                return
            }
            
            // アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする
            Auth.auth().createUser(withEmail: address, password: password) { user, error in
                if let error = error {
                    // エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                // 画面を閉じてViewControllerに戻る
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    
    

}
