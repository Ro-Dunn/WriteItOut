//
//  MoodDataChart.swift
//  WriteItOut
//
//  Created by Katy Dunn on 9/9/22.
//

import SwiftUI

struct MoodDataChart: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

        var body: some View {
            NavigationView {
                List {
                    ForEach(users, id: \.self) { user in
                        Text(user)
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    EditButton()
                }
            }
        }

        func delete(at offsets: IndexSet) {
            users.remove(atOffsets: offsets)
        }
}


struct MoodDataChart_Previews: PreviewProvider {
    static var previews: some View {
        MoodDataChart()
    }
}
