//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 30.05.2024.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var service = RickAndMortyService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(service)
        }
    }
}
