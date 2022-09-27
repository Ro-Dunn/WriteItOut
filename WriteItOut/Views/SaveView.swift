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
    
    @Binding var shouldPopToRootView : Bool
    
    @State var shareText: ShareText?
    @State var isWantingToShare: Bool
    @State var date:Date
    @State public var df = DateFormatter()
    
    
    var body: some View {
        ZStack{
            bohemianBackground(backgroundTracker: 2)
            VStack (spacing: 40){
                Form{
                    Text("Your Color Map")
                        .font(.subheadline)
                }
                .cornerRadius(25)
                .frame(minWidth: 0, idealWidth: 350, maxWidth: 350, minHeight: 0, idealHeight: 450, maxHeight: 450, alignment: .center)
                
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
