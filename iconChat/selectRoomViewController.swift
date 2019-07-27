//
//  selectRoomViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/24.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase

class selectRoomViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let uid = Auth.auth().currentUser?.uid
    
    var roomArray: [RoomData] = []
    
    // DatabaseのobserveEventの登録状態を表す
    var observing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "roomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "roomCell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableView.automaticDimension
        // テーブル行の高さの概算値を設定しておく
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 100

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            if self.observing == false {
                // 要素が追加されたらArrayに追加してTableViewを再表示する
                let roomsRef = Database.database().reference().child("Room")
                roomsRef.observe(.childAdded, with: { snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                    // PostDataクラスを生成して受け取ったデータを設定する
                    if let uid = Auth.auth().currentUser?.uid {
                        let roomData = RoomData(snapshot: snapshot, myId: uid)
                        self.roomArray.insert(roomData, at: 0)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
                roomsRef.observe(.childChanged, with: { snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    
                    if let uid = Auth.auth().currentUser?.uid {
                        // PostDataクラスを生成して受け取ったデータを設定する
                        let roomData = RoomData(snapshot: snapshot, myId: uid)
                        
                        // 保持している配列からidが同じものを探す
                        var index: Int = 0
                        for room in self.roomArray {
                            if room.id == roomData.id {
                                index = self.roomArray.firstIndex(of: room)!
                                break
                            }
                        }
                        
                        // 差し替えるため一度削除する
                        self.roomArray.remove(at: index)
                        
                        // 削除したところに更新済みのデータを追加する
                        self.roomArray.insert(roomData, at: index)
                        
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
                roomArray = []
                tableView.reloadData()
                // オブザーバーを削除する
                let roomsRef = Database.database().reference().child("Room")
                roomsRef.removeAllObservers()
                
                // DatabaseのobserveEventが上記コードにより解除されたため
                // falseとする
                observing = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! roomTableViewCell
        cell.setRoomData(roomArray[indexPath.row])
        
        // セル内のボタンのアクションをソースコードで設定する
        cell.entryButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        
        return cell
    }
    
    // セル内のボタンがタップされた時に呼ばれるメソッド
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: 入室ボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let roomData = roomArray[indexPath!.row]
        
        // Firebaseに保存するデータの準備
        if let uid = Auth.auth().currentUser?.uid {
            roomData.users.append(uid)
            
            //Firebaseに保存する
            let roomRef = Database.database().reference().child("Room").child(roomData.id!)
            let users = ["users": roomData.users]
            roomRef.updateChildValues(users)
            
        }
    }
    

   

}
