//
//  SignInVC.swift
//  JinyTalk
//
//  Created by 김미진 on 23/01/2019.
//  Copyright © 2019 김미진. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class SignInVC: UIViewController {

    @IBOutlet var userLabel: UILabel!
    @IBOutlet var userNick: UITextField!
    let uid = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").child(uid!).observe(DataEventType.value) { (snapshot) in
            let userpro = (snapshot.value as? [String: AnyObject] ?? [:] )
            self.userLabel.text = "환영합니다. \(userpro["name"]!) 님"
        }
//        Database.database().reference().child("users").child(uid!).setValue(["name":user.profile.name])
        // Do any additional setup after loading the view.
    }
    @IBAction func startButton(_ sender: Any) {
        if userNick.text != nil , userNick.text != "" {
            userNickSurch(userNick.text!) { isSuccess in
                if isSuccess {
                    print("성공")
                    let alert = UIAlertController(title: "사용가능", message: "\(self.userNick.text!) 을 사용하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.signInEvent()}))
                    self.present(alert, animated: true, completion: nil)
                    
                }else {
                    print("실패")
                    let alert = UIAlertController(title: "error", message: "이미 사용중인 닉네임입니다.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
            }
//            print("text입력됨")
//            Database.database().reference().child("usersNick").observe(DataEventType.value, with: { (snapshot) in
//                let userP = snapshot.value as? [String: String] ?? [:]
//                if userP.containsValue(value: self.userNick.text!) {
//                    let alert = UIAlertController(title: "error", message: "이미 사용중인 닉네임입니다.", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }else{
//                    let alert = UIAlertController(title: "사용가능", message: "\(self.userNick.text!) 을 사용하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil))
//                    alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler:))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            })
        } else {
            let alert = UIAlertController(title: "error", message: "닉네임을 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func userNickSurch(_ nick: String, completion: @escaping ((_ isSuccess: Bool) -> Void)) {
        Database.database().reference().child("usersNick").observe(DataEventType.value, with: { (snapshot) in
            let userP = snapshot.value as? [String: String] ?? [:]
            if userP.containsValue(value: nick) {
                completion(false)
            }else{
                completion(true)
            }
        })
    }
//    func userNickSurch(_ nick: String) -> Bool {
//        Database.database().reference().child("usersNick").observe(DataEventType.value, with: { (snapshot) in
//            let userP = snapshot.value as? [String: String] ?? [:]
//            if userP.containsValue(value: nick) {
//                return
//            }
//            return true
//        })
//    }
    @objc func signInEvent() -> Void{
        Database.database().reference().child("usersNick").setValue([uid : userNick.text!])
        Database.database().reference().child("users/\(uid!)/Nick").setValue(userNick.text!)
        Database.database().reference().child("users/\(uid!)/uid").setValue(uid)
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabVC") as! UITabBarController
        self.present(signInVC, animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
