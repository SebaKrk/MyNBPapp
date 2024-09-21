//
//  PaymentView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import SwiftUI

struct PaymentView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: PaymentViewModel
 
    // MARK: - Lifecycle
    
    init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            paymentButton
            receiptButton
        }
    }
    
    // MARK: - SubView
    
    private var paymentButton: some View {
        Button {
            viewModel.processPayment()
        } label: {
            Text("Process Payment")
        }
    }
    
    private var receiptButton: some View {
        Button {
            viewModel.generateReceipt(transactionId: "123456789")
        } label: {
            Text("Generate Receipt")
        }
    }
}
