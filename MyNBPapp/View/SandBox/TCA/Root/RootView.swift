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
//                    NavigationLink("Go to Contact Screen",
//                                   state: RootFeature.Path.State.contact(ContactsFeature.State())
//                    )
                    NavigationLink("Go to ScreenContact",
                                   state: RootFeature.Path.State.screenContact(ScreenContact.State())
                    )
                }
                
                Section {
                    Button("Go to A → A → B") {
                      store.send(.goToAAAButtonTapped)
                    }
                }
            }
            .sheet(
                item: $store.scope(state: \.destination?.openScreenFavorites, action:  \.destination.openScreenFavorites)
            ) { store in
                    FavoritesScreenView(store: store)
            }
            .navigationTitle("Root")
            .toolbar {
                factoriesRootButton
            }
        } destination: { store in
            switch store.case {
            case let .screenA(store):
                ScreenAView(store: store)
            case let .screenB(store):
                ScreenBView(store: store)
            case let .screenC(store):
                ScreenCView(store: store)
            case let .contact(store):
                ContactsView(store: store)
            case let .screenContact(store):
                ScreenContactView(store: store)
            }
        }
        
    }
    
    @ViewBuilder
    var factoriesRootButton: some View {
        Button {
            store.send(.favoritesButtonTapped)
        } label: {
            Image(systemName: "star")
        }
    }
    
}
