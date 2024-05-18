//
//  DateHelper.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation

class DateHelper {
    static var share = DateHelper()
    
    func getDate(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year

        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
    
    func dayOfWeek(for date: Date) -> Int? { // lay vi tri thu cua ngay //["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"]
        let calendar = Calendar.current
        let dayIndex = calendar.component(.weekday, from: date)
        return dayIndex - 1
    }
    
    func dayOfWeekString(for date: Date) -> String? { // lay vi tri thu cua ngay //["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"]
        let calendar = Calendar.current
        let dayIndex = calendar.component(.weekday, from: date)
        let day: [String] = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"]
        return day[dayIndex - 1]
    }
    
    func numberOfDays(month: Int, year: Int) -> Int? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month

        let calendar = Calendar.current

        // Lấy đối tượng Date từ các thành phần ngày, tháng, năm
        if let date = calendar.date(from: dateComponents) {
            // Lấy khoảng ngày trong tháng
            let range = calendar.range(of: .day, in: .month, for: date)
            // Trả về số ngày trong tháng
            return range?.count
        } else {
            return nil
        }
    }
    func nextMonth(month: Int!, year: Int!) -> [LichModel] {
        var lichThang: [LichModel] = [LichModel]()
        var newMonth: Int = month
        var newYear: Int = year
        
        if month == 12 {
            newMonth = 1
            newYear = year + 1
        }else{
            newMonth = month + 1
        }
        
        
        if let date = DateHelper.share.getDate(day: 1, month: newMonth, year: newYear), let dayOfWeek = DateHelper.share.dayOfWeek(for: date), let daysInMonth = DateHelper.share.numberOfDays(month: newMonth, year: newYear) {
            var num: Int = 1
            for i in 0..<42 {
                
                if i >= dayOfWeek, num <= daysInMonth {
//                    ngayDL.append(num)
                    lichThang.append(LichModel(ngay: num, thang: newMonth, nam: newYear))
                    num += 1
                }else {
                    lichThang.append(LichModel(ngay: 0, thang: newMonth, nam: newYear))
//                    ngayDL.append(0)
                }
            }
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
        
        return lichThang
    }
    func previousMonth(month: Int!, year: Int!) -> [LichModel] {
        var lichThang: [LichModel] = [LichModel]()
        var newMonth: Int = month
        var newYear: Int = year
        
        if month == 1 {
            newMonth = 12
            newYear = year - 1
        }else{
            newMonth = month - 1
        }
        
        if let date = DateHelper.share.getDate(day: 1, month: newMonth, year: newYear), let dayOfWeek = DateHelper.share.dayOfWeek(for: date), let daysInMonth = DateHelper.share.numberOfDays(month: newMonth, year: newYear) {
            var num: Int = 1
            for i in 0..<42 {
                
                if i >= dayOfWeek, num <= daysInMonth {
//                    ngayDL.append(num)
                    lichThang.append(LichModel(ngay: num, thang: newMonth, nam: newYear))
                    num += 1
                }else {
                    lichThang.append(LichModel(ngay: 0, thang: newMonth, nam: newYear))
//                    ngayDL.append(0)
                }
            }
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
        
        return lichThang
    }
    
    func nextDay(day: Int, month: Int!, year: Int!) -> LichModel {
        var lichNgay: LichModel = LichModel()
 
 
        
        if let date = DateHelper.share.getDate(day: day, month: month, year: year){
            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                lichNgay = LichModel(date: nextDate)
            } else {
                print("Không thể tính toán ngày tiếp theo")
            }
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
        
        return lichNgay
    }
    
    func prevDay(day: Int, month: Int!, year: Int!) -> LichModel {
        var lichNgay: LichModel = LichModel()
 
 
        
        if let date = DateHelper.share.getDate(day: day, month: month, year: year){
            if let nextDate = Calendar.current.date(byAdding: .day, value: -1, to: date) {
                lichNgay = LichModel(date: nextDate)
            } else {
                print("Không thể tính toán ngày tiếp theo")
            }
        } else {
            print("Không thể tạo ngày từ các thành phần cung cấp")
        }
        
        return lichNgay
    }
}
