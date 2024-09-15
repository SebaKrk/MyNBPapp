//
//  MapSearchTextField.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 14/09/2024.
//

import SwiftUI

struct MapSearchTextField: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for ...", text: $searchText)
                .autocorrectionDisabled()
        }
        .padding(12)
        .background(.white)
        .cornerRadius(8)
        .foregroundColor(.primary)
        .padding()
        .shadow(radius: 20)
    }
}
