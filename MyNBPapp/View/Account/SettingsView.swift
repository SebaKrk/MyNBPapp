//
//  SettingsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Text("SettingsView")
                .toolbar {
                    Button("Done") {
                        dismiss()
                    }
                }
        }
    }
    
}

