//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by George Chang on 2023-02-17.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var multiSelection = Set<UUID>()
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .onDelete { indice in
                scrums.remove(atOffsets: indice)
            }
        }
        .navigationTitle("Daily Scrum")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
    
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    isPresentingNewScrumView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            })
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationStack {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewScrumView.toggle()
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newScrum = DailyScrum(data: newScrumData)
                                scrums.append(newScrum)
                                isPresentingNewScrumView.toggle()
                                newScrumData = DailyScrum.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
