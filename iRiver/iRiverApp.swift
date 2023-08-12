//
//  iRiverApp.swift
//  iRiver
//
//  Created by laihungwei on 2023/8/12.
//

import SwiftUI

@main
struct iRiverApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
