//
//  Task+CoreDataProperties.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var comments: String?
    @NSManaged public var date: String?
    @NSManaged public var ofProject: Project?

}
