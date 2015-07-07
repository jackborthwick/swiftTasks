//
//  Tasks.swift
//  swiftTasks
//
//  Created by Jack Borthwick on 7/7/15.
//  Copyright (c) 2015 Jack Borthwick. All rights reserved.
//

import Foundation
import CoreData

@objc(Tasks)
class Tasks: NSManagedObject {

    @NSManaged var taskName: String
    @NSManaged var dateEntered: NSDate
    @NSManaged var taskDescription: String
    @NSManaged var taskDifficulty: NSNumber
    @NSManaged var dateUpdated: NSDate

}
