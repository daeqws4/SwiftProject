//
//  LoginViewC.swift
//  JinyTalk
//
//  Created by 김미진 on 08/01/2019.
//  Copyright © 2019 김미진. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewC: UIViewController , GIDSignInUIDelegate, GIDSignInDelegate{
    
    
    @IBOutlet weak var GoogleLogin: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("====")
        
        
    }
    
    
    @IBAction func GoogleButton(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            dump(error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        dump(credential)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                dump(error)
                return
            }
            // User is signed in
            // ...
            let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.present(signInVC, animated: false, completion: nil)
            print("여긴가")
            print(user.profile.email)
            print(user.profile.name)
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).setValue(["name":user.profile.name])
            
            
        }
        
        
        // ...
    }
    
}

