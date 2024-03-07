//
//  SettingsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: SettingsFeature.self)
struct SettingsView: View {
    
    var store: StoreOf<SettingsFeature>
    
    var body: some View {
//        WithPerceptionTracking {
            NavigationStack {
                Text("SettingsView")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                send(.userTapedCancelButton)
                            } label: {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                send(.userTapedDoneButton)
                            } label: {
                                Text("Done")
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }
//        }
    }
    
}
