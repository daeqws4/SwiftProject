//
//  LoadingViewC.swift
//  JinyTalk
//
//  Created by 김미진 on 07/01/2019.
//  Copyright © 2019 김미진. All rights reserved.
//

import UIKit
import Firebase


class LoadingViewC: UIViewController {
    
    var remoteConfig : RemoteConfig!

    override func viewDidLoad() {
        super.viewDidLoad()
//        try! Auth.auth().signOut()
        let uid = Auth.auth().currentUser?.uid
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = RemoteConfigSettings(developerModeEnabled: true)
        //서버랑 연결이 안될경우 디폴트 값
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        // Do any additional setup after loading the view.
        
        // TimeInterval is set to expirationDuration here, indicating the next fetch request will use
        // data fetched from the Remote Config service, rather than cached parameter values, if cached
        // parameter values are more than expirationDuration seconds old. See Best Practices in the
        // README for more information.
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            
            if let user = Auth.auth().currentUser {
                Database.database().reference().child("users").child(uid!).observe(DataEventType.value, with: { (snapshot) in
                    print(snapshot.value)
                    let userP = snapshot.value as? [String: String] ?? [:]
                    print(userP)
                    if userP.count <= 1{
                        print("가입된 닉네임도 없는디?")
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewC") as! LoginViewC
                        self.present(loginVC, animated: false, completion: nil)
                    }else {
                        print("로그인된상태입니다.")
                        print(user.email)
                        self.userPass()
                    }
                    //                    if userP.containsValue(value: nick) {
                    //                        completion(false)
                    //                    }else{
                    //                        completion(true)
                    //                    }
                })
//                print("로그인된상태입니다.")
//                print(user.email)
//                self.userPass()
            }else {
                self.displayWelcome()
            }
            
        }
        
        
        
    }
    
    func displayWelcome() {
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        
        if caps {
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in exit(0)
            }))
            self.present(alert, animated: true, completion: nil)
            self.view.backgroundColor = UIColor(hexString: color!)
        }else{
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewC") as! LoginViewC
            self.present(loginVC, animated: false, completion: nil)
        }
    }
    
    func userPass() {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabVC") as! UITabBarController
        self.present(mainVC, animated: false, completion: nil)
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

