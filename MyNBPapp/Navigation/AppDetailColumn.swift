//
//  AppDetailColumn.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI

struct AppDetailColumn: View {
    
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("select a tab",
                                       systemImage: "list.bullet.rectangle",
                                       description: Text("Pick something form ths tabbar list."))
            }
        }
    }
    
}
