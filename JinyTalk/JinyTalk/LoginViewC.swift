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

class LoginViewC: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var googleLogin: GIDSignInButton!
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print(error)
                return
            }
            // User is signed in
            // ...
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GIDSignIn.sharedInstance()?.uiDelegate = self.googleLogin as! GIDSignInUIDelegate
//        GIDSignIn.sharedInstance()?.signIn()
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

}
