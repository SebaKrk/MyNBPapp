//
//  MyNBPappApp.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/01/2024.
//

import SwiftUI
import SwiftData

@main
struct MyNBPappApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Favorite.self)
    }
}
