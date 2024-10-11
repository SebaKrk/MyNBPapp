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
    @State var inputAmount: String = "0"
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            VStack {
                if let method = selectedPaymentMethod {
                    let paymentFactory = selectedFactory(for: method)
                    let paymentService = PaymentService(factory: paymentFactory)
                    let viewModel = PaymentViewModel(paymentService: paymentService,
                                                     inputAmount: inputAmount)
                    PaymentView(viewModel: viewModel)
                } else {
                    VStack {
                        Text("Proszę wybrać metodę płatności")
                            .foregroundColor(.red)
                            .padding()
                        Text("Do zaplaty: \(inputAmount)")
                    }
                }
            }
            .toolbar {
                toolBarButton
            }
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
