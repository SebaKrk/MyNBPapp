//
//  AppSidebarList.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

struct AppSidebarList: View {
    
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("NBP Charts")
        .navigationBarTitleDisplayMode(.inline)
        .navigationSplitViewColumnWidth(225)
    }
    
}
