//
//  Project+CoreDataClass.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Project)
public class Project: NSManagedObject {
    var tasks: [Task]? {
        return self.task?.array as? [Task]
    }
    
    convenience init?(name: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Project.entity(), insertInto: context)
        self.name = name
    }
}
