//
//  FitMunityDevApp.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/17/25.
//

import SwiftUI

@main
struct FitMunityDevApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
