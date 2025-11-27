//
//  Connectfy_Bem_EstarApp.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import SwiftUI
import SwiftData

@main
struct Connectfy_Bem_EstarApp: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
