//
//  CardView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var cartViewModel: CartViewModel
    
    @Binding var showPaymentCard: Bool
    @Binding var paymnet: String?
    
    
    init(_ viewModel: CartViewModel,
         showPaymentCard: Binding<Bool>,
         paymnet: Binding<String?>) {
        self.cartViewModel = viewModel
        self._showPaymentCard = showPaymentCard
        self._paymnet = paymnet
        
    }
    
    var body: some View {
        List {
            ForEach(cartViewModel.items, id: \.id) { cartItem in
                if let package = cartItem.item as? PackagePresenter {
                    packageGroup(package, quantity: cartItem.quantity)
                } else {
                    productGroup(cartItem)
                }
            }
        }
        summaryView
        buyButton
    }
    
    private func productLabel(_ item: CartItem) -> some View {
        HStack {
            Text(item.item.name)
            Spacer()
            Text("\(item.quantity)")
        }
    }
    
    private func productRow(name: String, price: Int) -> some View {
        HStack {
            Text(name)
            Spacer()
            Text("\(price) PLN")
        }
    }
    
    private func productGroup(_ item: CartItem) -> some View {
        DisclosureGroup {
            ForEach(0..<item.quantity, id: \.self) { _ in
                productRow(name: item.item.name,
                           price: item.item.getPrice())
            }
        } label: {
            productLabel(item)
        }
    }
    
    private func packageGroup(_ package: PackagePresenter, quantity: Int) -> some View {
        DisclosureGroup {
            ForEach(package.products, id: \.id) { product in
                productRow(name: product.name,
                           price: product.price)
            }
        } label: {
            HStack {
                Text("\(package.name)")
                Spacer()
                Text("\(cartViewModel.totalProductsInPackage(for: package.id))")
            }
        }
    }
    
    private var summaryView: some View {
        HStack {
            Text("Liczba produktów: \(cartViewModel.totalItems)")
            Spacer()
            Text("Łączna cena: \(cartViewModel.totalPrice) PLN")
        }
        .padding()
    }
    
    private var buyButton: some View {
        Button {
            paymnet = String(cartViewModel.totalPrice)
            showPaymentCard = true
            cartViewModel.proceedToPayment()
            dismiss()
        } label: {
            Label("Kupuję i płace", systemImage: "creditcard")
        }
    }
    
}
