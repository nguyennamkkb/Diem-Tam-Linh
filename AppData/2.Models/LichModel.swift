//
//  LichModel.swift
//  ChonCat-App
//
//  Created by Mac mini on 16/05/2024.
//

import Foundation
import ObjectMapper
import VietnameseLunar


class LichModel: Mappable {

    var id: Int?
    var ngayDL: Int?
    var thangDL: Int?
    var namDL: Int?

    var ngayAL: Int?
    var thangAL: Int?
    var namAL: String?
    var thu: String?
    var trangThaiSuKien: Int?
    var trangThaiChon: Int?

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    init(){}
    init(date: Date){
        
        let calendar = Calendar.current
        // Trích xuất ngày, tháng và năm từ ngày hiện tại
        ngayDL = calendar.component(.day, from: date)
        thangDL = calendar.component(.month, from: date)
        namDL = calendar.component(.year, from: date)
        
        let vietnameseCalendar = VietnameseCalendar(date: date)
        
        ngayAL = vietnameseCalendar.vietnameseDate.day
        thangAL = vietnameseCalendar.vietnameseDate.month
        namAL = vietnameseCalendar.vietnameseDate.year
        thu = DateHelper.share.dayOfWeekString(for: date)
    }
    
    init(ngay: Int, thang: Int, nam: Int){
        
        ngayDL = ngay
        thangDL = thang
        namDL = nam
        let date = DateHelper.share.getDate(day: ngay, month: thang, year: nam)

        let vietnameseCalendar = VietnameseCalendar(date: date ?? Date())
        
        ngayAL = vietnameseCalendar.vietnameseDate.day 
        thangAL = vietnameseCalendar.vietnameseDate.month
        namAL = vietnameseCalendar.vietnameseDate.year
        
        thu = DateHelper.share.dayOfWeekString(for: date ?? Date())
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        ngayDL <- map["ngayDL"]
        thangDL <- map["thangDL"]
        namDL <- map["namDL"]
        
        ngayAL <- map["ngayAL"]
        thangAL <- map["thangAL"]
        namAL <- map["namAL"]
        
        trangThaiSuKien <- map["trangThaiSuKien"]
        trangThaiChon <- map["trangThaiChon"]
        
        thu <- map["thu"]
    }


}
