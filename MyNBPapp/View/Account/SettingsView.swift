//
//  SettingsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    
    var store: StoreOf<SettingsFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Text("SettingsView")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                viewStore.send(
                                    .userTapedCancelButton
                                )
                            } label: {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                viewStore.send(
                                    .userTapedDoneButton
                                )
                            } label: {
                                Text("Done")
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
}
