//
//  SaveView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/25/22.
//

import SwiftUI

struct SaveView: View {
    @State var shareText: ShareText?
    @EnvironmentObject var userJournal: UserJournal
    @Binding var shouldPopToRootView : Bool
    @State var isWantingToShare: Bool
    @State var date:Date
    @State public var df = DateFormatter()
    
    var body: some View {
        ZStack{
            bohemianBackground(backgroundTracker: 2)
            VStack {
                CircleView(label: df.string(from: date))
                    .frame(width: 100, height: 100)
                
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
