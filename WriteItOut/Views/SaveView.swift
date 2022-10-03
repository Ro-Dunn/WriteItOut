//
//  SaveView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/25/22.
//

import SwiftUI

struct SaveView: View {
    @EnvironmentObject var userJournal: UserJournal
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController:DataController
    
    @Binding var shouldPopToRootView : Bool
    
    @State var shareText: ShareText?
    @State var isWantingToShare: Bool
    @State var date:Date
    @State public var df = DateFormatter()
    @State public var thisColorSelected:String
    @State public var colorSelected:Bool
    @State public var dateOfEntry:Date = Date()
    @State var showMapElements = true
    @State private var showingAlert = false
    @State var state = "In"
    
    
    var body: some View {
        ZStack{
            bohemianBackground(backgroundTracker: 2)
            VStack (spacing: 40){
                if showMapElements == true{
                    Form{
                        Text("Make a map entry?")
                            .font(.subheadline)
                        
                        Circle()
                            .fill(colorSelected == true ? Color("\(thisColorSelected)") : Color("SystemColor"))
                            .frame(width: 80, height: 80)
                        
                        Section{
                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach (feelingArray) { feeling in
                                        CircleView(label: feeling)
                                            .onTapGesture {
                                                colorSelected = true
                                                thisColorSelected = feeling
                                            }
                                    }
                                    
                                }.padding(.top)
                            }
                            Section{
                                Button("Save Entry") {
                                    let newColorData = DailyColor(context: dataController.container.viewContext)
                                    df.dateStyle = DateFormatter.Style.short
                                    newColorData.dateString = (df.string(from: dateOfEntry))
                                    newColorData.color = thisColorSelected
                                    showMapElements = false
                                }
                            }.padding()
                        }
                    }
                    .cornerRadius(25)
                    .frame(minWidth: 0, idealWidth: 350, maxWidth: 350, minHeight: 0, idealHeight: 450, maxHeight: 450, alignment: .center)
                } else {
                    Form{
                        Text("Your entry has been saved.")
                            .font(.subheadline)
                        Section{
                           LottieView(lottieFile: "52644-checkmark-box")
                            
                        }
                        
                    }
                    .cornerRadius(25)
                    .frame(minWidth: 0, idealWidth: 350, maxWidth: 350, minHeight: 0, idealHeight: 450, maxHeight: 450, alignment: .center)
                    
                }
                
                
                HStack{
                    Button (action: { self.shouldPopToRootView = false } ){
                        Text("Finish")
                    }
                    .frame(minWidth: 0, maxWidth: 100)
                    .padding()
                    .background(Color("SystemColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    Button("Share") {
                        isWantingToShare = true
                    }
                    .frame(minWidth: 0, maxWidth: 100)
                    .padding()
                    .background(Color("SystemColor"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .alert("We won't save your entry...", isPresented: $isWantingToShare) {
                        Button("Would you like to take it?") {
                            shareText = ShareText(text: userJournal.currentJournal)
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                }
                .sheet(item: $shareText) { shareText in
                    ActivityView(text: shareText.text)
                }
            }
        }
    }
}



struct ActivityView: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}




struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}






//struct SaveView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveView()
//    }
//}
