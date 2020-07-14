//
//  Task+CoreDataClass.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Task)
public class Task: NSManagedObject {
    
    convenience init?(name: String, desc: String, comments: String, date: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Task.entity(), insertInto: context)
        
        self.name = name
        self.desc = desc
        self.comments = comments
        self.date = date
    }
}
