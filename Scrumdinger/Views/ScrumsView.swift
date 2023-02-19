//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by George Chang on 2023-02-17.
//

import SwiftUI

struct ScrumsView: View {
    let scrum: [DailyScrum]
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        List(scrum, selection: $multiSelection) { scrum in
            NavigationLink {
                DetailView(scrum: scrum)
            } label: {
                CardView(scrum: scrum)
            }
            .listRowBackground(scrum.theme.mainColor)
        }
        .navigationTitle("Daily Scrum")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            })
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScrumsView(scrum: DailyScrum.sampleData)
        }
    }
}
