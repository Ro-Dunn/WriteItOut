//
//  UserView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/18/22.
//

import SwiftUI

struct UserView: View {
    @State public var user: User
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Text("Name")
                    
                    TextField("Enter your name", text: $user.name )
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                VStack{
                    Text("Current Pattern")
                    HStack{
                        Button ("7-4-8") {
                            user.breathingSelection = sevenFourEight
                            
                            print("748 Pressed! Users pattern is now \(user.breathingSelection)")
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.3))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        
                        
                        
                        Button ("5-5-5") {
                            user.breathingSelection = fiveFiveFive
                            
                            print("555 pressed! Users pattern is now \(user.breathingSelection)")
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.3))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        
                        
                        
                        Button ("4-7-4") {
                            user.breathingSelection = fourSevenFour
                            
                            print("474 Pressed! Users pattern is now \(user.breathingSelection)")
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.3))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                    }
                }
                Text("Duration")
                GroupBox {
                    DisclosureGroup("Durration") {
                        Button("3 Rounds"){
                            user.breathingRounds = 3
                            print(user.name)
                            
                        }
                        .padding()
                        Button("5 Rounds"){
                            user.breathingRounds = 5
                            
                        }
                        .padding()
                        Button("8 Rounds"){
                            user.breathingRounds = 8
                        }
                        .padding()
                    }
                }
                
                //Color Map Display
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: dummyUser)
    }
}
