//
//  UserTVC.swift
//  JinyTalk
//
//  Created by 김미진 on 23/01/2019.
//  Copyright © 2019 김미진. All rights reserved.
//

import UIKit
import Firebase

class UserTVC: UITableViewController {
    var array : [UserModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            print(snapshot)
            for child in snapshot.children {
//                print(child)
                let fchild = child as! DataSnapshot
                let userModel = UserModel()
                let userSet = fchild.value as! [String:Any]
                print("=========")
                print(userSet)
                userModel.name = userSet["name"] as? String
                userModel.Nick = userSet["Nick"] as? String
//                print(fchild.value as! [String:Any])
                
//                let test = userModel
//                userModel.userName = "rlaalwls"
//                userModel.userNick = "test admin"
//                userModel.value(forKey: fchild.value as [:])
//                userModel.setValuesForKeys(fchild.value as! [String : Any])
                self.array.append(userModel)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        let row = array[indexPath.row]
        cell.userName.text = row.name
        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = array[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewC") else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
