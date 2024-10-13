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
//            ContentView()
//            SandBoxMapView()
//            ContentViewBuilder()
            ContentProductView()
        }
        .modelContainer(for: Favorite.self)
    }
}

