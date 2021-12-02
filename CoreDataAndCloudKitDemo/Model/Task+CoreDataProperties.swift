//
//  Task+CoreDataProperties.swift
//  CoreDataAndCloudKitDemo
//
//  Created by Vitor Gledison Oliveira de Souza on 02/12/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?

}

extension Task : Identifiable {

}
