//
//  LocationTableViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {

    var jsonNavigator = JsonNavigator(json: jsonResponse())
    var possibleLocations = [LocationCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("O")
        
        
        possibleLocations.append(LocationCard(name: "shallow", pictureName: "common_waterweed1")!)
        possibleLocations.append(LocationCard(name: "bottom", pictureName: "large_purple_bladderwort1")!)
        possibleLocations.append(LocationCard(name: "deep", pictureName: "landlocked_salmon1")!)
        possibleLocations.append(LocationCard(name: "surface", pictureName: "alternate_flowered_watermilfoil5")!)
        possibleLocations.append(LocationCard(name: "shoreline", pictureName: "green_water2")!)
        println(possibleLocations.count)

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println(possibleLocations.count)
        return possibleLocations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationTableViewCell", forIndexPath: indexPath) as! LocationTableViewCell
    
        println("Configuring cells")
        
        let path = NSBundle.mainBundle().pathForResource(possibleLocations[indexPath.item].pictureName, ofType: ".jpg")

        var image = UIImage()
        
        if(path != nil){
            image = UIImage(contentsOfFile: path!)!
        }
        
        cell.locationPicture.image = image
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

