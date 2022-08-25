//
//  SaveView.swift
//  WriteItOut
//
//  Created by Katy Dunn on 8/25/22.
//

import SwiftUI

struct SaveView: View {
    @State var shareText: ShareText?
    @EnvironmentObject var currentJournal: UserJournal

    var body: some View {
        VStack {
            Button("Show Activity View") {
                shareText = ShareText(text: "Would you like to take your journal with you?")
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






struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView()
    }
}
