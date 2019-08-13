//
//  agreeViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/08/13.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit

class agreeViewController: UIViewController {
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    private let checkedImage = UIImage(named: "check_on")
    private let uncheckedImage = UIImage(named: "check_off")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // agreeButtonの設定
        self.agreeButton.setImage(uncheckedImage, for: .normal)
        self.agreeButton.setImage(checkedImage, for: .selected)
        //関数
        checkNextButtonenable()
        
    }
    
    func checkNextButtonenable(){
        //同意チェック済みか判断する
        if self.agreeButton.isSelected {
            self.nextButton.tintColor = UIColor.white
            self.nextButton.layer.cornerRadius = 5
            self.nextButton.layer.borderWidth = 1
            self.nextButton.layer.backgroundColor = UIColor.blue.cgColor
        } else {
            self.nextButton.tintColor = UIColor.white
            self.nextButton.layer.cornerRadius = 5
            self.nextButton.layer.borderWidth = 1
            self.nextButton.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    //agreeButton
    @IBAction func agreeButton(_ sender: Any) {
        
        //選択状態を反転させる
        self.agreeButton.isSelected = !self.agreeButton.isSelected
        //関数
        checkNextButtonenable()
        
    }
    //nextButton
    @IBAction func nextButton(_ sender: Any) {        
        //同意チェック済みの場合のみアクションさせる
        if self.agreeButton.isSelected {
            print("次に進めます")
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        else{
            return
        }
    }
    

    

}
