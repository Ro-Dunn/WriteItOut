//
//  SetReminders.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/16/22.
//

import SwiftUI
import UserNotifications

struct SetReminders: View {
    @State var date = DateComponents()
    @AppStorage("alarm") var alarm: String = ""
    var body: some View {
        Text("When Would You A Reminder?")
            .font(.subheadline)
        Form {
            Section("Notification Prefereance") {
                Picker("Schedule Reminder", selection: $date) {
                    Group{
                        Text("1 am").tag(DateComponents(hour: 1))
                        Text("2 am").tag(DateComponents(hour: 2))
                        Text("3 am").tag(DateComponents(hour: 3))
                        Text("4 am").tag(DateComponents(hour: 4))
                        Text("5 am").tag(DateComponents(hour: 5))
                        Text("6 am").tag(DateComponents(hour: 6))
                    }
                    Group{
                        Text("7 am").tag(DateComponents(hour: 7))
                        Text("8 am").tag(DateComponents(hour: 8))
                        Text("9 am").tag(DateComponents(hour: 9))
                        Text("10 am").tag(DateComponents(hour: 10))
                        Text("11 am").tag(DateComponents(hour: 11))
                        Text("12 pm").tag(DateComponents(hour: 12))
                    }
                    Group{
                        Text("1 pm").tag(DateComponents(hour: 13))
                        Text("2 pm").tag(DateComponents(hour: 14))
                        Text("3 pm").tag(DateComponents(hour: 15))
                        Text("4 pm").tag(DateComponents(hour: 16))
                        Text("5 pm").tag(DateComponents(hour: 17))
                        Text("6 pm").tag(DateComponents(hour: 18))
                    }
                    Group {
                        Text("7 pm").tag(DateComponents(hour: 19))
                        Text("8 pm").tag(DateComponents(hour: 20))
                        Text("9 pm").tag(DateComponents(hour: 21))
                        Text("10 pm").tag(DateComponents(hour: 22))
                        Text("11 pm").tag(DateComponents(hour: 23))
                        Text("12 am").tag(DateComponents(hour: 24))
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            Button("Set Notifications") {
                reqeustPermiss()
                setNotif()
                print(alarm)
            }
            Button("Cancel Notifications") {
                deleteAlarm()
                print(alarm)
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
        
        // show this notification five seconds from now
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        alarm = request.identifier
    }
}

struct SetReminders_Previews: PreviewProvider {
    static var previews: some View {
        SetReminders()
    }
}


