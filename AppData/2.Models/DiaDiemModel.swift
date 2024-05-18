//
//  DiaDiemModel.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import Foundation
import ObjectMapper

class DiaDiemModel: Mappable {

    var id: Int?

    var title: String?
    var lat: Double?
    var long: Double?
    var note: String?
    var loaiLich: Int? //0: am, 1: duong
    var ngay: Int?
    var thang: Int?
    var nam: String?
    

    var notification: Bool?
    var status: Int?

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    init(title: String, lat: Double, long: Double, note: String, loaiLich: Int, ngay: Int, thang: Int, nam: String, notification: Bool, status: Int) {
        self.title = title
        self.lat = lat
        self.long = long
        self.note = note
        self.loaiLich = loaiLich
        self.ngay = ngay
        self.thang = thang
        self.nam = nam
        self.notification = notification
        self.status = status
      
    }
    init(){}
 

    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        title <- map["title"]
        lat <- map["lat"]
        long <- map["long"]
        note <- map["note"]
        loaiLich <- map["loaiLich"]
        ngay <- map["ngay"]
        thang <- map["thang"]
        nam <- map["nam"]
        
        notification <- map["notification"]
        status <- map["status"]
    }


}
