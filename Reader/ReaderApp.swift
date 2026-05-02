//
//  ReaderApp.swift
//  Reader
//
//  Created by Alessandro Tecce on 4/23/26.
//

import Library
import SwiftUI
import SwiftData

@main
struct ReaderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    NavigationLink("Go to Bible View") {
                        BibleView(book: Name.revelation, chapter: 22, verse_start: 15, verse_end: 16)
                    }
                    NavigationLink("Go to Content View") {
                        ContentView()
                    }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
