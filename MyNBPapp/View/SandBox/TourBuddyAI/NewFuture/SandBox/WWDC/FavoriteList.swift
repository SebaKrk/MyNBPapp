//
//  FavoriteList.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 11/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
struct FavoriteList: View {
    
    var favorite: [MKMapItem]
    @State private var selected: MKMapItem?

    var body: some View {
        List(favorite, id: \.self, selection: $selected) {
            Text($0.name ?? "brak")
        }
        .mapItemDetailSheet(item: $selected)
    }
}
