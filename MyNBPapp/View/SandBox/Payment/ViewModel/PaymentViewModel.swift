//
//  PaymentViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/09/2024.
//

import SwiftUI

class PaymentViewModel: ObservableObject {
    
    let paymentService: PaymentServiceProtocol
    @Published var paymentState: paymentState = .selection
    
    @Published var inputAmount: String = ""
    @Published var receipt: Receipt?
    @Published var paymentError: Error?
    
    @Published var showReceipt: Bool = false {
         didSet {
             if !showReceipt {
                 resetPaymentState()  
             }
         }
     }
    
    init(paymentService: PaymentServiceProtocol) {
        self.paymentService = paymentService
    }
    
    @MainActor
    func processPayment(amount: Double) async {
        paymentState = .processing
        do {
            let receipt = try await paymentService.processPayment(amount: amount)
            self.receipt = receipt
            paymentState = .success
        } catch {
            self.paymentError = error
            paymentState = .failed
            print("Payment failed, state: \(paymentState)")
        }
    }
    
    func retryPayment() {
        paymentState = .selection
        inputAmount = ""
        paymentError = nil
    }
    
    func resetPaymentState() {
         paymentState = .selection
         inputAmount = ""
         paymentError = nil
         receipt = nil
     }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
}

enum paymentState {
    case selection
    case processing
    case success
    case failed
}
