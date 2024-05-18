//
//  SuKienModel.swift
//  ChonCat-App
//
//  Created by Mac mini on 17/05/2024.
//

import Foundation
import ObjectMapper

class SuKienModel: Mappable {

    var id: Int?
    var ngay: LichModel?
    var title: String?
    var note: String?
    

    var notification: Bool?
    var status: Int?

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    init(){}
    init(ngay: LichModel){
        self.ngay = ngay
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        ngay <- map["ngay"]
        title <- map["title"]
        note <- map["note"]
        
        notification <- map["notification"]
        status <- map["status"]
    }


}
