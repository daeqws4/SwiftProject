//
//  MoviesLiustVC.swift
//  Boost
//
//  Created by 김미진 on 13/12/2018.
//  Copyright © 2018 김미진. All rights reserved.
//

import UIKit


class MoviesLiustVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("돌아가고는있니")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        print("reload되었니")
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
            return 1
    }
    struct User {
        var userId: Int
        var id: Int
        var title: String
        var completed: Bool
        init(_ dictionary: [String: Any]) {
            self.userId = dictionary["userId"] as? Int ?? 0
            self.id = dictionary["id"] as? Int ?? 0
            self.title = dictionary["title"] as? String ?? ""
            self.completed = dictionary["completed"] as? Bool ?? false
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as! MoviesCell
        let cellId = "moviesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MoviesCell
        
        print("여기까진드러오니")
        
        do {
            let url = URL(string: "http://connect-boxoffice.run.goorm.io/")


            let row = 1

            let ImageURL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=0")
            let response = try String(contentsOf: ImageURL!)

//            let result =             print(result)
//            print(response)
            let data = try Data(contentsOf: ImageURL!)
            let object = try JSONSerialization.jsonObject(with: data, options: [[]]) as? NSDictionary

            print(((object!["movies"] as! NSArray)[0] as! NSDictionary)["title"])

            cell.MovieName?.text = ((object!["movies"] as! NSArray)[0] as! NSDictionary)["title"] as! String
            cell.MovieEx?.text = response



        }catch let e as NSError {
            print(e.localizedDescription)
        }

        return cell
    }
 
    func load(Key: String) -> String {
        do{
            let ImageURL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=0")
            let data = try Data(contentsOf: ImageURL!)
            
        }catch let e as NSError {
            print(e.localizedDescription)
        }
        let objectdata = try JSONSerialization.jsonObject(with: data, options: [[]]) as? NSDictionary
        let values = ((objectdata!["movies"] as! NSArray)[0] as! NSDictionary)[Key] as! String
        return values
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
