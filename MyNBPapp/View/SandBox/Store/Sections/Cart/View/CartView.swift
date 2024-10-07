//
//  CardView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var cartViewModel: CartViewModel
    
    init(_ viewModel: CartViewModel) {
        self.cartViewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(cartViewModel.items, id: \.id) { cartItem in
                HStack {
                    Text(cartItem.item.name)
                    Spacer()
                    Text("\(cartItem.quantity)")
                }
            }
        }
        HStack {
            Text("Liczba produktów: \(cartViewModel.totalItems())")
            Spacer()
            Text("Łączna cena: \(cartViewModel.totalPrice()) PLN")
        }
        .padding()
    }
    
}
