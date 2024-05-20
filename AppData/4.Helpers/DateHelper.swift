//
//  DateHelper.swift
//  BaseApp
//
//  Created by namnl on 24/04/2023.
//

import Foundation
import VietnameseLunar


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
            for i in 0..<(dayOfWeek + daysInMonth) {
                
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
            for i in 0..<(dayOfWeek + daysInMonth) {
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
    
    func getDateComponents(from date: Date) -> (day: Int, month: Int, year: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        
        guard let day = components.day, let month = components.month, let year = components.year else {
            fatalError("Failed to get date components.")
        }
        
        return (day, month, year)
    }
    
    func amLichSangDuongLich(day: Int, month: Int, year: Int) -> LichModel{
        //chuyen am lich sang duong lich
        
        //nhap vao ngay am nhung lay moc la ngay duong
        //tinh ngay duong sang ngayf aam de lay ngay am trung voi ngay da nhap
        
        // tra tra nhay duong trung voi ngay da nhap
        
//        print("Am lich sang duong")
        let oldDay: Int = day
        let oldMonth: Int = month
        let oldYear: String = canChi(nam: year)
//        
//        print(year)
//        print(oldYear)
        var day = LichModel(ngay: day, thang: month, nam: year)
        for _ in 0...100 {
            
            let nextday = nextDay(day: day.ngayDL ?? 1, month: day.thangDL ?? 1, year: day.namDL ?? 1970)
            day = nextday
//            print(day.canChi ?? "")
//            print(day.canChi == oldYear)
            if day.ngayAL == oldDay, day.thangAL == oldMonth, day.canChi == oldYear {
                return day
            }
        }

        return day
    }
    func canChi(nam: Int) -> String {
//        let thienCan = ["Giáp", "Ất", "Bính", "Đinh", "Mậu", "Kỷ", "Canh", "Tân", "Nhâm", "Quý"]
//       
//        
//        let indexThienCan = (nam - 4) % 10
        
        var can: String = "";
        switch (nam % 10) {
        case 0:
            can = "Canh";
            break;
        case 1:
            can = "Tân";
            break;
        case 2:
            can = "Nhâm";
            break;
        case 3:
            can = "Quý";
            break;
        case 4:
            can = "Giáp";
            break;
        case 5:
            can = "Ất";
            break;
        case 6:
            can = "Bính";
            break;
        case 7:
            can = "Mậu";
            break;
        case 8:
            can = "MẬU";
            break;
        case 9:
            can = "Kỷ";
            break;
        default:
            can = "";
        }
        
        let diaChi = ["Tý", "Sửu", "Dần", "Mão", "Thìn", "Tỵ", "Ngọ", "Mùi", "Thân", "Dậu", "Tuất", "Hợi"]
        var chi: String = "";
        switch(nam % 12){
        case 0:
            chi="Thân";
            break;
        case 1:
            chi="Dậu";
            break;
        case 2:
            chi="Tuất";
            break;
        case 3:
            chi="Hợi";
            break;
        case 4:
            chi="Tý";
            break;
        case 5:
            chi="Sửu";
            break;
        case 6:
            chi="Dần";
            break;
        case 7:
            chi="Mão";
            break;
        case 8:
            chi="Thìn";
            break;
        case 9:
            chi="Tỵ";
            break;
        case 10:
            chi="Ngọ";
            break;
        case 11:
            chi="Mùi";
            break;
        default:
            chi = ""
        }

        
        return "\(can) \(chi)"
    }
    
}
