//
//  Payment.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import SwiftUI

struct Payment: View {
    
    // MARK: - Properties
    
    @State private var selectedPaymentMethod: PaymentMethod?
    
    // MARK: - View
    
    var body: some View {
        VStack {
            if let method = selectedPaymentMethod {
                let paymentFactory = selectedFactory(for: method)
                let viewModel = PaymentViewModel(paymentFactory,
                                                 amount: 100)
                PaymentView(viewModel: viewModel)
            } else {
                Text("Proszę wybrać metodę płatności")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .toolbar {
            toolBarButton
        }
    }
    
    // MARK: - SubViews
    
    @ToolbarContentBuilder
    private var toolBarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            paymentMethod
        }
    }
    
    @ViewBuilder
    private var paymentMethod: some View {
        Menu {
            paymentMethodButtonMenu
        } label: {
            Image(systemName: "creditcard.circle")
        }
    }
    
    @ViewBuilder
    private var paymentMethodButtonMenu: some View {
        ForEach(PaymentMethod.allCases, id: \.self) { item in
            Button {
                selectedPaymentMethod = item
            } label: {
                Text(item.title)
            }
        }
    }
    
    // MARK: - Methods
    
    private func selectedFactory(for method: PaymentMethod) -> PaymentFactory {
        switch method {
        case .paypal:
            return PayPalFactory()
        case .applePay:
            return ApplePayFactory()
        }
    }
    
    
}
