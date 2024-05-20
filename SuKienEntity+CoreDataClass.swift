//
//  SuKienEntity+CoreDataClass.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//
//

import Foundation
import CoreData
import ObjectMapper

@objc(SuKienEntity)
public class SuKienEntity: NSManagedObject {
    func getDateString() -> String {
        let ngay = Mapper<NgayModel>().map(JSONString: ngay ?? "")
        let amLich = ngay?.loaiLich == 0
        let s = "\(ngay?.ngay ?? 0)-\(ngay?.thang ?? 0)-\(ngay?.nam ?? 0) \(amLich ? "AL" : "DL")"
        return s
    }
    
    func getDate() -> Date? {
        let ngay = Mapper<NgayModel>().map(JSONString: ngay ?? "")
        var dateComponents = DateComponents()
        dateComponents.day = ngay?.ngay
        dateComponents.month = ngay?.thang
        dateComponents.year = ngay?.nam

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    
    
}
