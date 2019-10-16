//
//  HomeTableViewController.swift
//  InfoApp
//
//  Created by 15251462 on 19/9/2019.
//  Copyright © 2019 MTCHOY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class HomeTableViewController: UITableViewController {
    
    //var jsonResults:JSON?;
    var realmResults:Results<HomeEvent>?
    var Details_name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Location", Realm.Configuration.defaultConfiguration.fileURL!)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(downloadJson), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        
        downloadJson()
        print("Refresh successfylly")
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        if let results = jsonResults {
            cell.textLabel?.text = results[indexPath.row]["name"].stringValue
        }
        
        
        return cell
    }
     */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        // Configure the cell...
        
        if let cellImage = cell.viewWithTag(100) as? UIImageView {
            
            let url = realmResults?[indexPath.row].imgURL
            
            if let unwrappedUrl = url {
                
                Alamofire.request(unwrappedUrl).responseData {
                    response in
                    
                    if let data = response.result.value {
                        cellImage.image = UIImage(data: data, scale:1)
                    }
                }
            }
            
        }
        if let cellLabel = cell.viewWithTag(101) as? UILabel {
            cellLabel.text = realmResults?[indexPath.row].name
        }
        
        return cell
    }
    
    @objc func downloadJson() {
        
        // The Realm + Alamofire codes in `viewDidLoad()`
        
        let realm = try! Realm()
        
        let url = "https://shrouded-temple-80031.herokuapp.com/event"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            
            print("Result: \(response.result)") // response serialization result
            
            switch response.result {
                
            case .success(let value):
                
                //  print("JSON: \(value)")     // serialized json response
                // self.jsonResults = JSON(value)  // deserialization
                //print("A record: \(self.jsonResults?[0]["name"].stringValue ?? "No Data" )")
                
                let jsonResults:JSON = JSON(value)
                
                // Delete all objects from the realm
                try! realm.write {
                    realm.deleteAll()
                }
                
                for index in 0..<jsonResults.count {
                    
                    let homeevent = HomeEvent()
                    homeevent.name = jsonResults[index]["name"].stringValue
                    homeevent.event_id = jsonResults[index]["id"].stringValue
                    homeevent.quota = jsonResults[index]["quota"].stringValue
                    homeevent.venue = jsonResults[index]["venue"].stringValue
                    homeevent.organizer = jsonResults[index]["organizer"].stringValue
                    homeevent.shortDescription = jsonResults[index]["organizer"].stringValue
                    homeevent.fullDescription = jsonResults[index]["fullDescription"].stringValue
                    homeevent.imgURL = jsonResults[index]["imgURL"].stringValue
                    homeevent.date = jsonResults[index]["date"].stringValue
                    homeevent.time = jsonResults[index]["time"].stringValue
                    
                    //print("homeevent: \(String(describing: homeevent.image))")
                    
                    try! realm.write {
                        realm.add(homeevent)
                    }
                }
                
                self.realmResults = realm.objects(HomeEvent.self)
                
                print("\(self.realmResults!.count)")
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            return results.count
        }else{
            return 0
        }
        
        refreshControl?.endRefreshing()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetails" {
            
            if let viewController = segue.destination as? DetailsTableViewController {
                
                var selectedIndex = tableView.indexPathForSelectedRow!
                
                print("SelectIndex \(selectedIndex)")
                viewController.Details_name = realmResults?[selectedIndex.row].name ?? "0"
            }
        }
    }

}
