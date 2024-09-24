//
//  PaymentViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/09/2024.
//

import SwiftUI

class PaymentViewModel: ObservableObject {
    
    let paymentService: PaymentServiceProtocol
    
    @Published var inputAmount: String = ""
    @Published var receipt: Receipt?
    @Published var paymentError: Error?
    
    @Published var showReceipt: Bool = false
    
    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }
    
    @MainActor
    func processPayment(amount: Double) async {
        do {
            let receipt = try await paymentService.processPayment(amount: amount)
            self.receipt = receipt
            self.showReceipt = true
        } catch {
            self.paymentError = error
            self.showReceipt = false
        }
    }
    
}
