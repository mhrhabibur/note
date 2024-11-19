//
//  Notes+CoreDataProperties.swift
//  Note
//
//  Created by Habibur Rahman on 11/18/24.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var detail: String?
    @NSManaged public var title: String?

}

extension Notes : Identifiable {

}
