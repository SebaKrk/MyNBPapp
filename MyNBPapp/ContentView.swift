//
//  ContentView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selection: AppScreen? = .chatGPT
    
    var body: some View {
         
        if horizontalSizeClass == .compact {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
