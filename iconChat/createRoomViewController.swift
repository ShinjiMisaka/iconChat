import UIKit
import Firebase
import SVProgressHUD

class createRoomViewController: UIViewController {
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomNumberTextField: UITextField!
    
    
    
    
    // ボタンをタップしたときに呼ばれるメソッド
    @IBAction func createButton(_ sender: Any) {
        
    
        let roomName = roomNameTextField.text!
        let number = roomNumberTextField.text!
        let uid = Auth.auth().currentUser?.uid
        
        
        // 辞書を作成してFirebaseに保存する
        let roomRef = Database.database().reference().child("Room")
        let roomDic = ["roomName": roomName, "number":number, "users":uid]
        roomRef.childByAutoId().setValue(roomDic)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "部屋が作られました！")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
