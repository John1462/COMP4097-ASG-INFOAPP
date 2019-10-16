//
//  EventTableViewController.swift
//  InfoApp
//
//  Created by 15251462 on 12/9/2019.
//  Copyright © 2019 MTCHOY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class EventTableViewController: UITableViewController {

     var organizer:String = "No Data"
     var Details_name:String = "No Data"
     var jsonResults:JSON?;
     var realmResults:Results<HomeEvent>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.organizer
        //print(self.organizer)
        
          let realm = try! Realm()
                
        let url = "https://shrouded-temple-80031.herokuapp.com/event"
               
        Alamofire.request(url, method: .get).validate().responseJSON { response in
                   
        print("Result: \(response.result)") // response serialization result
                   
            switch response.result {
                            
                case .success(let value):
                    
                    let jsonResults:JSON = JSON(value)
                    
                    self.realmResults = realm.objects(HomeEvent.self).filter("organizer == '\(self.organizer)'")
                        
                    print("\(self.realmResults!.count)")
                    
    //                self.jsonResults = JSON(value)
//                    print("A record: \(self.jsonResults?[0]["name"].stringValue ?? "No Data" )")
//                    print(self.organizer)
                    
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
        
        if let results = realmResults{
            //print("Data count: \(results.count)")
            return results.count
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "depteventCell", for: indexPath)
           
           // Configure the cell...
        
//        if let results = jsonResults {
//              // cell.textLabel?.text = results[indexPath.row].name
//               cell.textLabel?.text = results[indexPath.row]["name"].stringValue
//           }
        if let results = realmResults {
            cell.textLabel?.text = results[indexPath.row].name
        }
           
           return cell
       
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           // Get the new view controller using segue.destinationViewController.
//           // Pass the selected object to the new view controller.
//

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
         if segue.identifier == "showEvent1" {
           
            if let viewController = segue.destination as? DetailsTableViewController {
                             
            var selectedIndex = tableView.indexPathForSelectedRow!
                   
            //print("SelectIndex \(selectedIndex)")
            viewController.Details_name = realmResults?[selectedIndex.row].name ?? "0"
            print("ViewController2" +  (realmResults?[selectedIndex.row].name ?? "0"))
                         }

               }
        }
}
