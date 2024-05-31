//
//  RootView.swift
//  MyNBPapp
//
//  Created by Sebastian Ściuba on 28/05/2024.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            Form {
                Section {
                    NavigationLink(
                        "Go to screen A",
                        state: RootFeature.Path.State.screenA(ScreenA.State())
                    )
                    NavigationLink(
                        "Go to screen B",
                        state: RootFeature.Path.State.screenB(ScreenB.State())
                    )
                    NavigationLink(
                        "Go to screen C",
                        state: RootFeature.Path.State.screenC(ScreenC.State())
                    )
                }
                Section {
                    Button("Go to A → A → B") {
                      store.send(.goToAAAButtonTapped)
                    }
                }
            }
            .navigationTitle("Root")
        } destination: { store in
            switch store.case {
            case let .screenA(store):
                ScreenAView(store: store)
            case let .screenB(store):
                ScreenBView(store: store)
            case let .screenC(store):
                ScreenCView(store: store)
            }
        }
    }
    
}
