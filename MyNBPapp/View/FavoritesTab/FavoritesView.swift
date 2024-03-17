//
//  FavoritesView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI
import Observation

struct FavoritesView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Text("FavoritesView")
                    Text("FavoritesView")
                    Text("FavoritesView")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.yellow)
        }
    }
    
}
