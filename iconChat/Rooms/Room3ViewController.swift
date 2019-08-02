import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD

class Room3ViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var number : Int = 0
    var postArray: [PostData] = []
    // DatabaseのobserveEventの登録状態を表す
    var observing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoURLString = Auth.auth().currentUser?.photoURL?.absoluteString
        let reference = Storage.storage().reference(forURL: photoURLString!)
        
        self.imageView.sd_setImage(with: reference)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "入室しました")
        SVProgressHUD.dismiss(withDelay: 1)
        //デリゲート
        commentTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "postCell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableView.automaticDimension
        // テーブル行の高さの概算値を設定しておく
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.setPostData(postArray[indexPath.row])
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            if self.observing == false {
                // 要素が追加されたらpostArrayに追加してTableViewを再表示する
                let postsRef = Database.database().reference().child("Room3")
                postsRef.observe(.childAdded, with: { snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                    // PostDataクラスを生成して受け取ったデータを設定する
                    if let uid = Auth.auth().currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, at: 0)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
                postsRef.observe(.childChanged, with: { snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    
                    if let uid = Auth.auth().currentUser?.uid {
                        // PostDataクラスを生成して受け取ったデータを設定する
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        
                        // 保持している配列からidが同じものを探す
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.firstIndex(of: post)!
                                break
                            }
                        }
                        
                        // 差し替えるため一度削除する
                        self.postArray.remove(at: index)
                        
                        // 削除したところに更新済みのデータを追加する
                        self.postArray.insert(postData, at: index)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                
                // DatabaseのobserveEventが上記コードにより登録されたため
                // trueとする
                observing = true
            }
        } else {
            if observing == true {
                // ログアウトを検出したら、一旦テーブルをクリアしてオブザーバーを削除する。
                // テーブルをクリアする
                postArray = []
                tableView.reloadData()
                // オブザーバーを削除する
                let postsRef = Database.database().reference().child("Room3")
                postsRef.removeAllObservers()
                
                // DatabaseのobserveEventが上記コードにより解除されたため
                // falseとする
                observing = false
            }
        }
    }
    
    //退室ボタン
    @IBAction func outButton(_ sender: Any) {
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "退室しました")
        SVProgressHUD.dismiss(withDelay: 1)
        // キーボードを閉じる
        commentTextField.resignFirstResponder()
        
    }
    //送信ボタン
    @IBAction func sentButton(_ sender: Any) {
        // ImageViewから画像を取得する
        let imageData = self.imageView.image!.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        // postDataに必要な情報を取得しておく
        let name = Auth.auth().currentUser?.displayName
        let comment = commentTextField.text
        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child("Room3")
        let postDic = ["comment": comment , "image": imageString, "name": name!]
        postRef.childByAutoId().setValue(postDic)
        
        commentTextField.text = ""
    }
    
    //キーボードを閉じる(画面タップ時)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.tableView.endEditing(true)
    }
    
    //キーボードを閉じる(return押下し時)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
}


