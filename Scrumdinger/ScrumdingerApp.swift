//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by George Chang on 2023-02-17.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                
            }
            .onAppear {
                ScrumStore.load { result in
                    switch result {
                    case .success(let scrums):
                        store.scrums = scrums
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
}
