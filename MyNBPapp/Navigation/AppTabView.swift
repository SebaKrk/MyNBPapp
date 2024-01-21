//
//  AppTabView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

struct AppTabView: View {
    
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
    
}
