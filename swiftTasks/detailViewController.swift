//
//  detailViewController.swift
//  swiftTasks
//
//  Created by Jack Borthwick on 7/7/15.
//  Copyright (c) 2015 Jack Borthwick. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext:NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var selectedTask : Tasks?
    private var currentTask  : Tasks!
    @IBOutlet private var saveButton  :UIBarButtonItem!
    @IBOutlet private var taskNameTextField :UITextField!
    @IBOutlet private var taskTextView :UITextView!
    @IBOutlet private var taskCategorySegmentedControl :UISegmentedControl!


    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        taskTextView.resignFirstResponder()
        taskNameTextField.resignFirstResponder()    
    }
    
    //MARK: interactivity methods
    func saveTaskPressed(sender: UIBarButtonItem) {
        currentTask.taskName = taskNameTextField.text
        currentTask.taskDescription = taskTextView.text
        currentTask.taskDifficulty = taskCategorySegmentedControl.selectedSegmentIndex
        currentTask.dateUpdated = NSDate()
        appDelegate.saveContext()
        navigationController!.popViewControllerAnimated(true)
        
    }
    
    func deleteButtonPressed(sender: UIBarButtonItem) {
        println("delete")
        managedObjectContext.deleteObject(currentTask)
        appDelegate.saveContext()
        navigationController!.popViewControllerAnimated(true)
    }
    
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskNameTextField.delegate = self;
        self.taskTextView.delegate = self;
        var deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteButtonPressed:")
        var saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveTaskPressed:")
        self.navigationItem.rightBarButtonItems = [deleteButton,saveButton]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let unwrappedTask = selectedTask {
            //set the values that need to be set when a task was selected not new task
            taskNameTextField.text = unwrappedTask.taskName
            taskTextView.text = unwrappedTask.taskDescription
            taskCategorySegmentedControl.selectedSegmentIndex = IntegerLiteralType(unwrappedTask.taskDifficulty)
            currentTask = unwrappedTask
        }
        else {
            let entityDescription : NSEntityDescription! = NSEntityDescription.entityForName("Tasks", inManagedObjectContext: managedObjectContext)
            currentTask = Tasks(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
            currentTask.taskName = ""
            currentTask.taskDescription = ""
            currentTask.dateEntered = NSDate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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