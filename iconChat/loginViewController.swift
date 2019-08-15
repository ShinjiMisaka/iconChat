//
//  loginViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/24.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

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
            
            SVProgressHUD.show(withStatus: "ログイン中")
            
            Auth.auth().signIn(withEmail: address, password: password) { user, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showSuccess(withStatus: "ログイン失敗")
                    SVProgressHUD.dismiss(withDelay: 1)
                    return
                }
                print("DEBUG_PRINT: ログインに成功しました。")
                
                SVProgressHUD.showSuccess(withStatus: "ログイン完了")
                SVProgressHUD.dismiss(withDelay: 1)
                // 遷移
                let agreeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Agree")
                self.present(agreeViewController!, animated: true, completion: nil)
                
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
            
            SVProgressHUD.show(withStatus: "アカウント作成中")
            
            // アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする
            Auth.auth().createUser(withEmail: address, password: password) { user, error in
                if let error = error {
                    // エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showSuccess(withStatus: "アカウント作成失敗")
                    SVProgressHUD.dismiss(withDelay: 1)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                SVProgressHUD.showSuccess(withStatus: "アカウント作成完了")
                SVProgressHUD.dismiss(withDelay: 1)
                // 遷移
                let agreeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Agree")
                self.present(agreeViewController!, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    
    

}
