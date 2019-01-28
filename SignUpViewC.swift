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
import FirebaseStorage

class SignUpViewC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var UserId: UITextField!
    @IBOutlet weak var UserPassword: UITextField!
    @IBOutlet weak var UserPasswordCheck: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var Userimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Userimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
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
            if let error = err {
                print(error.localizedDescription)
                dump(error.localizedDescription)
                dump(err)
                return
            }
//            let uid = user!.user.uid
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).setValue(["name":self.UserName.text])

////            let image = UIImage.jpegData(self.Userimage.image!)
//            let image = self.Userimage.image
//            let imageData = image?.jpegData(compressionQuality: 0.1)

//            Storage.storage().reference().child("userImages").child(uid!).putData(imageData!, metadata: nil, completion: { ( data, error ) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                data?.storageReference?.downloadURL(completion: { (url, error) in
//                    if let error = error {
//                         print(error.localizedDescription)
//                        return
//                    }
//                    Database.database().reference().child("users").child(uid!).setValue(["name":self.UserName.text])
//                })
//            })

//            Storage.storage().reference().child("userImages").child(uid!).putData(imageData!, metadata: nil, completion: { (data, error) in
//                data?.storageReference?.downloadURL(completion: { (URL, error) in
//                    Database.database().reference().child("users").child(uid!).setValue(["name":self.UserName.text!,"profileImageURL":URL!])
//                })
//            })
        }
    }
    @objc func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        Userimage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        signupEvent()
    }
    @IBAction func CancleButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
