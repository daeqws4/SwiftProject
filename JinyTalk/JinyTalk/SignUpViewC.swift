//
//  SignUpViewC.swift
//  JinyTalk
//
//  Created by 김미진 on 08/01/2019.
//  Copyright © 2019 김미진. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewC: UIViewController {

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var UserId: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserPasswordCheck: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func signupEvent() {
        Auth.auth().createUser(withEmail: UserId.text!, password: UserPassword.text!) { (user, err) in
//            let uid = user!.user.uid
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).setValue(["name":self.UserName.text])
        }
    }
    @IBAction func signupButton(_ sender: Any) {
        signupEvent()
    }
    @IBAction func CancleButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
