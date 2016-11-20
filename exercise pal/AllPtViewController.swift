//
//  AllPtViewController.swift
//  
//
//  Created by admin on 11/20/16.
//
//

import UIKit

class AllPtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let exercises = ["Thumb raises", "Arm Curls, 1lb weight", "Index finger lifts", "Leg slides, left and right", "Diaphragm release", "Wrist raises"]
    let exercisesSubtitle = ["10 reps", "10reps", "20 reps, hold 2 secs", "30 reps", "10 reps", "30 reps"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.exercises[indexPath.row]
        cell.detailTextLabel?.text = self.exercisesSubtitle[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(indexPath.row)")
        
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
