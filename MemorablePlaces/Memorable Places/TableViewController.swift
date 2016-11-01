//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Hatice Gursoy on 8/1/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit
import CoreData



//Selected cell index number


var activePlace = -1

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //override func viewWillDisappear(animated: Bool) {
        
      //  MemorablePlaceManager.sharedInstance.fetchMemorablePlacesDatabase()
    //}
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemorablePlaceManager.sharedInstance.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let place = MemorablePlaceManager.sharedInstance.getMemorablePlaceAtIndex(indexPath.row)
        
        cell.textLabel?.text = place.locationName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
        performSegue(withIdentifier: "details", sender: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "details"
        {
            return false
        }
        
        return true
    }
    
    //Reset location to current location when user hits add button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newPlace" {
            activePlace = -1
        }
    }
    
    //Do I really need this? It works without this function. Why?
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
           // places.removeAtIndex(indexPath.row) // Remove the item from array first before removing from tableView
         MemorablePlaceManager.sharedInstance.removememorablePlaceAt(indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
}
