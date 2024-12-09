//
//  MyNBPappApp.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/01/2024.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct MyNBPappApp: App {
    var body: some Scene {
        WindowGroup {
            ViewPickerTCA(
                store: Store(
                    initialState: PickerFeatureTCA.State(),
                    reducer: { PickerFeatureTCA(service: DefaultService())
                    })
            )
//            ContentView()
//            SandBoxMapView()
//            ContentViewBuilder()
//            ContentProductView()
        }
        .modelContainer(for: Favorite.self)
    }
}

