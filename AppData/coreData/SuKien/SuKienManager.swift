//
//  SuKienManager.swift
//  ChonCat-App
//
//  Created by Mac mini on 18/05/2024.
//

import Foundation
import UIKit
import CoreData
import ObjectMapper

class SuKienManager {

    static let shared = SuKienManager() // Singleton

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}

    // Thêm một SuKienEntity mới
    func addSuKien(e: SuKienModel) -> Bool {
        let newSuKien = SuKienEntity(context: context)
        newSuKien.id = UUID()
        newSuKien.ngay = e.ngay?.toJSONString()
        newSuKien.title = e.title
        newSuKien.note = e.note
        newSuKien.notification = e.notification ?? false
        newSuKien.status = Int16(e.status ?? 0)
        
        
        // them su kien
        if newSuKien.notification {
            EventManager.share.requestCalendarAccess { (stt) in
                if stt {
                    EventManager.share.addEvent(ev: newSuKien)
                } else {
                    print("Access denied")
                    // Xử lý trường hợp bị từ chối quyền truy cập
                }
            }
        }
        
        
        do {
            try context.save()
            return true
        } catch {
            print("Không thể thêm sự kiện: \(error.localizedDescription)")
            return false
        }
    }

    // Lấy danh sách các SuKienEntity từ Core Data
    func getAllSuKien() -> [SuKienModel] {
        var suKienEntities = [SuKienEntity]()
        var suKienModel = [SuKienModel]()

        let fetchRequest: NSFetchRequest<SuKienEntity> = SuKienEntity.fetchRequest()

        do {
            suKienEntities = try context.fetch(fetchRequest)
        } catch {
            print("Không thể lấy danh sách sự kiện: \(error.localizedDescription)")
        }
        
        for e in suKienEntities {
            let sk = SuKienModel()
            sk.title = e.title
            sk.ngay =  Mapper<NgayModel>().map(JSONString: e.ngay ?? "")
            sk.note = e.note
            sk.notification = e.notification
            sk.status = Int(e.status)
            suKienModel.append(sk)
        }
        
        return suKienModel
    }
    // Lấy danh sách các SuKienEntity từ Core Data
    func getAllSuKien2() -> [SuKienEntity] {
        var suKienEntities = [SuKienEntity]()
        

        let fetchRequest: NSFetchRequest<SuKienEntity> = SuKienEntity.fetchRequest()

        do {
            suKienEntities = try context.fetch(fetchRequest)
        } catch {
            print("Không thể lấy danh sách sự kiện: \(error.localizedDescription)")
        }

        return suKienEntities
    }

    // Cập nhật thông tin của một SuKienEntity
    func updateSuKien(suKien: SuKienEntity, e: SuKienModel) -> Bool {
        suKien.ngay = e.ngay?.toJSONString()
        suKien.title = e.title
        suKien.note = e.note
        suKien.notification = e.notification ?? false
        suKien.status = Int16(e.status ?? 0)

        // them su kien
        if suKien.notification {
            EventManager.share.requestCalendarAccess { (stt) in
                if stt {
                    EventManager.share.editEvent(eventIdentifier: "\(suKien.id ?? UUID())", ev: suKien)
                } else {
                    print("Access denied")
                    // Xử lý trường hợp bị từ chối quyền truy cập
                }
            }
        }
        
        do {
            try context.save()
            print("Đã cập nhật sự kiện thành công!")
            return true
        } catch {
            print("Không thể cập nhật sự kiện: \(error.localizedDescription)")
            return false
        }
    }
    
    func updateNotiSuKien(suKien: SuKienEntity, notification: Bool) -> Bool {
      
        suKien.notification = notification


        do {
            try context.save()
            print("Đã cập nhật sự kiện thành công!")
            return true
        } catch {
            print("Không thể cập nhật sự kiện: \(error.localizedDescription)")
            return false
        }
    }


    // Xoá một SuKienEntity
    func deleteSuKien(suKien: SuKienEntity) {
        context.delete(suKien)

        do {
            try context.save()
            print("Đã xoá sự kiện thành công!")
        } catch {
            print("Không thể xoá sự kiện: \(error.localizedDescription)")
        }
    }
}
