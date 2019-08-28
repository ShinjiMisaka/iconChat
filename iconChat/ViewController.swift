//
//  ViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/20.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD
import MessageUI

class ViewController: UIViewController,UITextFieldDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mailButton: UIButton!
    var iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/nothing2.png")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //通報ボタン
        mailButton.addTarget(self, action: #selector(ViewController.startMailer(sender:)), for: .touchUpInside)
        self.view.addSubview(mailButton)
        //デリゲート
        nameTextField.delegate = self
        //関数
        initButton()
        //初期アイコン
        let iconImage = UIImage(named: "nothing2")
        iconImageView.image = iconImage
        
        // タイトルをセット
        self.navigationItem.title = "アイコン作成"
        
        
    }
    //viewDidLoadの次に実行される
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            // ログインしていないときの処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
    }
    
    //メーラー
    @objc func startMailer(sender: UIButton) {
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients = ["info@chamidog.com"]
        
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("お問い合わせ")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setMessageBody("お問い合わせ内容：", isHTML: false)
        
        present(mailViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            print("キャンセルしました")
            self.dismiss(animated: true, completion: nil)
        case .saved:
            print("セーブしました")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("送信しました")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("失敗しました。")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func initButton() {
        //UIButtonを画像にする
        button1.setImage(UIImage.init(named: "death"), for: UIControl.State.normal)
        button2.setImage(UIImage.init(named: "girl"), for: UIControl.State.normal)
        button3.setImage(UIImage.init(named: "god"), for: UIControl.State.normal)
        button4.setImage(UIImage.init(named: "hime"), for: UIControl.State.normal)
        button5.setImage(UIImage.init(named: "magicman"), for: UIControl.State.normal)
        button6.setImage(UIImage.init(named: "man"), for: UIControl.State.normal)
        button7.setImage(UIImage.init(named: "oldman"), for: UIControl.State.normal)
        button8.setImage(UIImage.init(named: "sportman"), for: UIControl.State.normal)
        button9.setImage(UIImage.init(named: "tono"), for: UIControl.State.normal)
        
    }
    //名前の文字制限
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength: Int = 8
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = nameTextField.text! + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if str.count <= maxLength {
            return true
        }
        print("8文字を超えています")
        return false
    }
    
    //アイコンを押した時
    @IBAction func button1(_ sender: Any) {
        let iconImage1 = UIImage(named: "death")
        iconImageView.image = iconImage1
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/death.png")
    }
    @IBAction func button2(_ sender: Any) {
        let iconImage2 = UIImage(named: "girl")
        iconImageView.image = iconImage2
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/girl.png")
    }
    @IBAction func button3(_ sender: Any) {
        let iconImage3 = UIImage(named: "god")
        iconImageView.image = iconImage3
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/god.png")
    }
    @IBAction func button4(_ sender: Any) {
        let iconImage4 = UIImage(named: "hime")
        iconImageView.image = iconImage4
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/hime.png")
    }
    @IBAction func button5(_ sender: Any) {
        let iconImage5 = UIImage(named: "magicman")
        iconImageView.image = iconImage5
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/magicman.png")
    }
    @IBAction func button6(_ sender: Any) {
        let iconImage6 = UIImage(named: "man")
        iconImageView.image = iconImage6
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/man.png")
    }
    @IBAction func button7(_ sender: Any) {
        let iconImage7 = UIImage(named: "oldman")
        iconImageView.image = iconImage7
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/oldman.png")
    }
    @IBAction func button8(_ sender: Any) {
        let iconImage8 = UIImage(named: "sportman")
        iconImageView.image = iconImage8
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/sportman.png")
    }
    @IBAction func button9(_ sender: Any) {
        let iconImage9 = UIImage(named: "tono")
        iconImageView.image = iconImage9
        iconURL = URL(string: "gs://iconchat-1f5b4.appspot.com/tono.png")
    }
    
    //エントリーしたら
    @IBAction func entryButton(_ sender: Any) {
        
        SVProgressHUD.show(withStatus: "読み込み中")
        //無効
        UIApplication.shared.beginIgnoringInteractionEvents()
        //名前が空欄なら名無しにする
        if nameTextField.text == "" {
            nameTextField.text = "名無し"
        }
        
        if let displayName = nameTextField.text {
            // 表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        // プロフィールの更新でエラーが発生
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    
                }
            }
        }
        
        if let photoURL = iconURL {
            // 表示画像を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.photoURL = photoURL
                changeRequest.commitChanges { error in
                    if let error = error {
                        // プロフィールの更新でエラーが発生
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [photURL = \(user.photoURL!)]の設定に成功しました。")
                    //アイコン作成
                    SVProgressHUD.showSuccess(withStatus: "完了")
                    SVProgressHUD.dismiss(withDelay: 1)
                    // タッチイベントを有効にする.
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
        }
        
    }
    
    
    //キーボードを閉じる(画面タップ時)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //キーボードを閉じる(return押下し時)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    

}

