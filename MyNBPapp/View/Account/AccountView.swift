//
//  AccountView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/01/2024.
//

import SwiftUI

struct AccountView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("AccountView")
                .toolbar {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                .navigationTitle("Account")
                .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isPresented) {
            SettingsView()
        }
    }
}
