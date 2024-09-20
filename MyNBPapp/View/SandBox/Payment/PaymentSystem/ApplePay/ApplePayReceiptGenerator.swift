//
//  File.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct ApplePayReceiptGenerator: ReceiptGenerator {
    
    func generateReceipt(transactionId: String) -> String {
        "ApplePay receipt for transaction: \(transactionId)"
    }
    
}
