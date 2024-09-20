//
//  PayPalReceiptGenerator.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct PayPalReceiptGenerator: ReceiptGenerator {
    
    func generateReceipt(transactionId: String) -> String {
        "PayPal receipt for transaction: \(transactionId)"
    }
    
}
