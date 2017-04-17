//
//  CommentViewController.swift
//  Instagram
//
//  Created by 宮崎大芽 on 2017/04/17.
//  Copyright © 2017年 taiga.miyazaki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD


class CommentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var caputionLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    
    var postData:PostData!
    //コメント投稿ボタン
    @IBAction func commentButton(_ sender: Any) {
        let name = FIRAuth.auth()?.currentUser?.displayName
        // 辞書を作成してFirebaseを更新する
        postData.comments.append("\(name!) : \(commentTextField.text!)")
        let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
        let comments = ["comments": postData.comments]
        postRef.updateChildValues(comments)
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    //コメントキャンセルボタン
    @IBAction func commentCansel(_ sender: Any) {
        //画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = postData.image
        caputionLabel.text = "\(postData.name!):\n\(postData.caption!)"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
}
