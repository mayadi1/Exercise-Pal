//
//  PtCollectionTableViewController.swift
//  exercise pal
//
//  Created by admin on 11/20/16.
//  Copyright © 2016 Melissa Perenson. All rights reserved.
//

import UIKit
import Firebase

class PtCollectionTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var name = [""]
    var rap = [""]
    var image = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        
        ref.observeEventType(.ChildAdded) { (snapshot, error) -> Void in
            let data = snapshot.value
            var myInfo = (data as! NSArray) as Array
            
            self.name.append(myInfo[0] as! String)
            self.rap.append(myInfo[1] as! String)
            self.image.append(myInfo[2] as! String)
            self.tableview.reloadData()
            
        }

  
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.name.count
        
        
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

   
        cell.textLabel?.text = self.name[indexPath.row]
        cell.detailTextLabel?.text = self.rap[indexPath.row]
           
            if let url = NSURL(string:self.image[indexPath.row]) {
                if let data = NSData(contentsOfURL: url) {
                    cell.imageView?.image = UIImage(data: data)
                }        
            }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
