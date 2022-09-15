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
    
    var body: some View {
        VStack {
            VStack {
                Button (action: { self.shouldPopToRootView = false } ){
                    Text("Finish")
                }
                .frame(minWidth: 0, maxWidth: 100)
                .padding()
                .background(Color("SystemColor"))
                .clipShape(Capsule())
                .foregroundColor(.white)
            }
            
            
            Text("""
                 Hey, we don't save your entiries, in order to allow you to write without consequence.
                
                 But if you'd like to take the entry with you on your clipboard or share it through text to yourself or others- please feel free to do so!
                """)
            .padding()
            
            Button("Would you like to share your entry?") {
                shareText = ShareText(text: userJournal.currentJournal)
            }
            .padding()
        }
        .sheet(item: $shareText) { shareText in
            ActivityView(text: shareText.text)
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
