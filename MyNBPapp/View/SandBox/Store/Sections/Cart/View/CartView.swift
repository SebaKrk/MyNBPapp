//
//  CardView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var cardViewModel: CartViewModel
    
    init(cardViewModel: CartViewModel) {
        self.cardViewModel = cardViewModel
    }
    
    var body: some View {
        List {
            ForEach(cardViewModel.items, id: \.id) { item in
                Text(item.name.description)
            }
        }
    }
    
}
