//
//  ViewController.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/20.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func entryButton(_ sender: Any) {
        
    }
    

}

