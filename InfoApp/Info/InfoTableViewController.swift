//
//  InfoTableViewController.swift
//  InfoApp
//
//  Created by John Yang on 16/10/2019.
//  Copyright © 2019 MTCHOY. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
//
    @IBOutlet weak var Head: UITableViewCell!
    
    @IBOutlet weak var Log: UITableViewCell!
    
    @IBOutlet weak var Reg: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let headCell = Head
        
        if let cellLabel = headCell?.viewWithTag(301) as? UILabel{
            cellLabel.text = UserDefaults.standard.string(forKey: "userid") ?? "Please login first!!"
        }
        
        let logCell = Log
        
        if let cellLabel = logCell?.viewWithTag(302) as? UILabel{
            cellLabel.text = "Login/Logout"
        }
        
        let regCell = Reg
        
        if let cellLabel = regCell?.viewWithTag(303) as? UILabel{
            cellLabel.text = "Registered Events"
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Head", for: indexPath)
//
//        // Configure the cell...
//        cell.textLabel?.text = "abc"
//
//        return cell
//    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "deptCell", for: indexPath)
//
//         // Configure the cell...
//         cell.textLabel?.text = deptArray[indexPath.row].organizer
//         
//         return cell
//     }

}
