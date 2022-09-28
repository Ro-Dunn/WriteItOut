//
//  SetReminders.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/16/22.
//

import SwiftUI
import UserNotifications

struct SetReminders: View {
//    @State var date = DateComponents()
    @State var datePickerDate = Date()
    @State var triggerComponents:DateComponents?
    @AppStorage("alarm") var alarm: String = ""
    init(){
        retriveNotifications()
    }
    var body: some View {
        Text("When Would You Like A Reminder?")
            .font(.subheadline)
        Form {
            Section("Notification Prefereance") {
                DatePicker( selection: $datePickerDate, displayedComponents: .hourAndMinute){
                    Text("Date Picker")
                }
            }
            Button("Set Notifications") {
                reqeustPermiss()
                setNotif()
                retriveNotifications()
                print(alarm)
            }
            Button("Cancel Notifications") {
                deleteAlarm()
                print(alarm)
            }
            
            Section{
                if let triggerComponents = triggerComponents, let hour = triggerComponents.hour, let minute = triggerComponents.minute {
                    Text("You have an alarm set for \(hour) : \(minute)")
                } else {
                    //
                }
            }
        }//end form
    }
    
    func  retriveNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            if let first = requests.first, let calendarTrigger = first.trigger as? UNCalendarNotificationTrigger {
               triggerComponents = calendarTrigger.dateComponents
            }
        }
    }
    
    func deleteAlarm(){
        var callIt: [String] = []
        callIt.append(alarm)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: callIt)
        alarm = ""
        callIt = []
    }
    
    func reqeustPermiss(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                //Good Job
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func setNotif(){
        let content = UNMutableNotificationContent()
        content.title = "Write It Out"
        content.subtitle = "Take Time To Journal Today"
        content.sound = UNNotificationSound.default
        let hour = Calendar.current.component(.hour, from: datePickerDate)
        let minute = Calendar.current.component(.minute, from: datePickerDate)
        let components = DateComponents(hour: hour,
                                        minute: minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        alarm = request.identifier
    }
}

struct SetReminders_Previews: PreviewProvider {
    static var previews: some View {
        SetReminders()
    }
}


