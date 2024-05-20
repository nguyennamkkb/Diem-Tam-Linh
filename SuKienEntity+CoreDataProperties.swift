//
//  SuKienEntity+CoreDataProperties.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//
//

import Foundation
import CoreData


extension SuKienEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuKienEntity> {
        return NSFetchRequest<SuKienEntity>(entityName: "SuKienEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var ngay: String?
    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var notification: Bool
    @NSManaged public var status: Int16

}

extension SuKienEntity : Identifiable {

}
