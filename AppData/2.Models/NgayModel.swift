//
//  NgayModel.swift
//  ChonCat-App
//
//  Created by Mac mini on 19/05/2024.
//

import Foundation
import ObjectMapper
class NgayModel: Mappable {

    var id: Int?
    var ngay: Int?
    var thang: Int?
    var nam: Int?

    var loaiLich: Int? //0:am lich, 1: duong lich
    var trangThai: Int?

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    init(){}

    init(date: Date){
        
        let calendar = Calendar.current
        // Trích xuất ngày, tháng và năm từ ngày hiện tại
        ngay = calendar.component(.day, from: date)
        thang = calendar.component(.month, from: date)
        nam = calendar.component(.year, from: date)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        ngay <- map["ngay"]
        thang <- map["thang"]
        nam <- map["nam"]
        
        loaiLich <- map["loaiLich"]
        trangThai <- map["trangThai"]
    }
    func getDate() -> Date? {
        
        
        var dateComponents = DateComponents()
        dateComponents.day = self.ngay
        dateComponents.month = self.thang
        dateComponents.year = self.nam

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }

}
