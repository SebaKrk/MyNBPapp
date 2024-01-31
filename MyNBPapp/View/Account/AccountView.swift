//
//  AccountView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import ComposableArchitecture
import SwiftUI

struct AccountView: View {
    
    var store: StoreOf<AccountFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Text("Account View")
                    .toolbar {
                        Button {
                            viewStore.send(.userTappedSettingsButton)
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    .navigationTitle("Account")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(store: store.scope(state: \.$settingsFeature, action: \.settingsFeature)) { store in
                SettingsView(store: store)
            }
        }
    }
    
}
