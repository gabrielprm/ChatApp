//
//  CDAnnotation+CoreDataProperties.swift
//  Mapp
//
//  Created by Pedro Ésli Vieira do Nascimento on 18/11/21.
//
//

import Foundation
import CoreData


extension CDAnnotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAnnotation> {
        return NSFetchRequest<CDAnnotation>(entityName: "CDAnnotation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?

}

extension CDAnnotation : Identifiable {

}
