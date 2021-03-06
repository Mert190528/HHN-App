//  Gruppe 1 <-

//  Gruppenmitglieder:
//  1. Mert Sürü (190528)
//  2. Valmir Muhaheri(190500)
//  3. Marco Vivod (190539)
//  4. Mustafa Ünaldi (190532)


//  LocationListController.swift
//  HHN-App
//
//  Created by Mert Sürü on 30.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationListController: UITableViewController {

    let targetNames = [
        "Campus Heilbronn: Am Europaplatz           Weiperstraße 47                                            74076 Heilbronn",
        "Campus Heilbronn: Sontheim         Max-Planck-Straße 39                    74081 Heilbronn",
        "Campus Schwäbisch Hall                     Ziegeleiweg 4                                                   74523 Schwäbisch Hall",
        "Campus Künzelsau                           Daimlerstraße 35                                                                          74653 Künzelsau"
    ]
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationListeTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationListeTableViewCell else {
                fatalError("Error")
        }

        cell.locationLabel.text = targetNames[indexPath.row]
        cell.mapButton.tag = indexPath.row
        cell.mapButton.addTarget(self, action: #selector(LocationListController.mapAction(_:)), for: .touchUpInside)
        cell.navigationButton.tag = indexPath.row
             cell.navigationButton.addTarget(self, action: #selector(LocationListController.navigationAction(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func navigationAction(_ sender:UIButton!) {
        
        self.performSegue(withIdentifier: "listToNavigation", sender: sender)
    }
    
    func mapAction(_ sender:UIButton!) {
        
        self.performSegue(withIdentifier: "listToMap", sender: sender)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? NavigationViewController
        if destination != nil {
            destination?.currentLocation = currentLocation
            destination?.targetIndex = (sender as? UIButton)?.tag
        }
       
        let destination2 = segue.destination as? MapViewController
        if destination2 != nil {
            destination2?.targetIndex = (sender as? UIButton)?.tag
        }
    }
   
}
