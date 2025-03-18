//
//  FitMunityDevApp.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

@main
struct FitMunityDevApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                // Force light mode to ensure consistent appearance
                .preferredColorScheme(.light)
        }
    }
}
