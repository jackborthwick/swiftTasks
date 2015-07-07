//
//  ViewController.swift
//  swiftTasks
//
//  Created by Jack Borthwick on 7/7/15.
//  Copyright (c) 2015 Jack Borthwick. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext:NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var tasksArray = [Tasks]()
    @IBOutlet private var tableView :UITableView!
    
    //MARK - database methods
    
    func fetchContacts(searchText: String) -> [Tasks] {
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Tasks")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"taskName", ascending:true)]
        return managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [Tasks]
    }
    
    //MARK - table view methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as!UITableViewCell
        let currentTask = tasksArray[indexPath.row]
        cell.textLabel!.text = currentTask.taskName
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editToDetailSegue", sender: self)
    }
    
    func addButtonPressed(sender: UIBarButtonItem) {
        println("add")
        performSegueWithIdentifier("addToDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "addToDetailSegue" {
            destController.selectedTask = nil
        }
        if segue.identifier == "editToDetailSegue" {
            let indexPath = tableView.indexPathForSelectedRow()
            if let uwIndexPath = indexPath {
                let currentTask = tasksArray[uwIndexPath.row]
                destController.selectedTask = currentTask
                tableView.deselectRowAtIndexPath(uwIndexPath, animated: true)
            }
        }
        
    }
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItems = [addButton]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tasksArray = fetchContacts("")
        println(tasksArray.count)
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

