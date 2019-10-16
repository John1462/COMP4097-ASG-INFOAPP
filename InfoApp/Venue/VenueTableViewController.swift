//
//  DeptTableViewController.swift
//  InfoApp
//
//  Created by 15251462 on 12/9/2019.
//  Copyright © 2019 MTCHOY. All rights reserved.
//

import UIKit
import RealmSwift

class VenueTableViewController: UITableViewController {
    
    var venue_name:String = "VENUE"
    var venue_id:String = ""
    var realmResults:Results<Venue>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = venue_name
        
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "venuedb", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
            
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
            
        // Read some data from the bundled Realm
        realmResults = realm.objects(Venue.self)
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
                if let results = realmResults {
            return results.count
        }else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "venueCell", for: indexPath)

        // Configure the cell...
        if let results = realmResults {
            cell.textLabel?.text = results[indexPath.row].VenueName
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showVenue" {
            
            if let viewController = segue.destination as? VenueEventTableViewController {
                
                var selectedIndex = tableView.indexPathForSelectedRow!
      
               //print("SelectIndex \(selectedIndex)")                
                viewController.venue_id = realmResults?[selectedIndex.row].VenueID ?? "0"
                //print("ViewController2" +  (realmResults?[selectedIndex.row].VenueID ?? "0"))
            }
        }
    }

}
