//
//  SettingsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView2: View {
    
    var store: StoreOf<SettingsFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Text("SettingsView")
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                viewStore.send(
                                    .userTapedCancleButton
                                )
                            } label: {
                                Text("Cancle")
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

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Text("SettingsView")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                        } label: {
                            Text("Cancle")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Done")
                        }
                    }
                    
                }
//            
//                .toolbar {
//                    Button("Done") {
//                        dismiss()
//                    }
//                }
        }
    }
    
}

