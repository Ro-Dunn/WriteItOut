//
//  SetReminders.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/16/22.
//

import SwiftUI
import UserNotifications

struct SetReminders: View {
    @State var datePickerDate = Date()
    @State var triggerComponents:DateComponents?
    @State var center = UNUserNotificationCenter.current()
    @AppStorage("alarm") var alarm: String?
    @State var whatTime:String = ""

    
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
                UserDefaults.standard.set(self.alarm, forKey: "alarm")
            }
            Button("Cancel Notifications") {
                if let alarm = alarm {
                    // If there is already an alarm set, cancel it
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm])
                }
                alarm = nil
                whatTime = ""
            }
            
            Section{
                Text("You have a daily remider set for \(whatTime)")
            }
        }
    }//end form
    
    func deleteAlarms(at offsets: IndexSet) {
    }
    
    func reqeustPermiss(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                UserDefaults.standard.set(self.alarm, forKey: "alarm")
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
        
        if let alarm = alarm {
            // If there is already an alarm set, cancel it
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm])
        }
        whatTime = "\(String(hour)):\(String(minute))"
        alarm = request.identifier
    }
}

struct SetReminders_Previews: PreviewProvider {
    static var previews: some View {
        SetReminders()
    }
}


