//
//  AccountView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: AccountFeature.self)
struct AccountView: View {
    
    var store: StoreOf<AccountFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                Text("Account View")
                    .toolbar {
                        Button {
                            send(.userTappedSettingsButton)
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
