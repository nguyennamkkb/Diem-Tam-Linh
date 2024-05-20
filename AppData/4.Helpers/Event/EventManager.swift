//
//  EventManager.swift
//  ChonCat-App
//
//  Created by Mac mini on 20/05/2024.
//

import Foundation
import EventKit


class EventManager {
    static var share = EventManager()
    
    let eventStore = EKEventStore()
    
    func requestCalendarAccess( completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { (granted, error) in
            DispatchQueue.main.async {
                if granted {
                    print("Access granted")
                    completion(true)
                    
                } else {
                    print("Access denied")
                    completion(false)
                }
            }
        }
    }
    
    func addEvent(ev: SuKienEntity) {
        let event = EKEvent(eventStore: eventStore)
        event.title = ev.title
        event.startDate = ev.getDate()
        event.endDate = event.startDate
        event.isAllDay =  true
//        event.endDate = event.startDate.addingTimeInterval(60 * 60 * 12)
        
        event.calendar = eventStore.defaultCalendarForNewEvents
        event.notes = "\(ev.note ?? "") \n \n \(ev.id ?? UUID())"
        
        // Thêm thông báo trước 1 ngày (24 giờ)
        let alarm1DayBefore = EKAlarm(relativeOffset: -24 * 60 * 60)
        event.addAlarm(alarm1DayBefore)

        // Thêm thông báo trước 12 giờ
        let alarm12HoursBefore = EKAlarm(relativeOffset: -12 * 60 * 60)
        event.addAlarm(alarm12HoursBefore)
        
        
        
        do {
            try eventStore.save(event, span: .thisEvent, commit: true)
            print("Event added")
        } catch let error {
            print("Failed to save event with error: \(error)")
        }
    }
    
    func editEvent(eventIdentifier: String, ev: SuKienEntity) {
        let predicate = eventStore.predicateForEvents(withStart: Date().addingTimeInterval(-3600*24*365), end: Date().addingTimeInterval(3600*24*365), calendars: nil)
        
        let events = eventStore.events(matching: predicate).filter { event in
            return event.notes?.contains("\(ev.id ?? UUID())") ?? false
        }
        
        
        
        if let event = eventStore.event(withIdentifier: events.first?.eventIdentifier ?? "") {
            event.title = ev.title

            event.startDate = ev.getDate()
            event.endDate = event.startDate.addingTimeInterval(60 * 60 * 12)
            event.calendar = eventStore.defaultCalendarForNewEvents
            event.notes = "\(ev.note ?? "") \n \n \(ev.id ?? UUID())"
            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
                print("Event updated")
            } catch let error {
                print("Failed to update event with error: \(error)")
            }
        }
    }
    
    func deleteEvent(byCustomID customID: String) {
            let predicate = eventStore.predicateForEvents(withStart: Date().addingTimeInterval(-3600*24*365), end: Date().addingTimeInterval(3600*24*365), calendars: nil)
            
            let events = eventStore.events(matching: predicate).filter { event in
                return event.notes?.contains("\(customID)") ?? false
            }
            
            if let event = events.first {
                do {
                    try eventStore.remove(event, span: .thisEvent, commit: true)
                    print("Event deleted with custom ID")
                } catch let error {
                    print("Failed to delete event with error: \(error)")
                }
            } else {
                print("No event found with custom ID")
            }
        }
}
