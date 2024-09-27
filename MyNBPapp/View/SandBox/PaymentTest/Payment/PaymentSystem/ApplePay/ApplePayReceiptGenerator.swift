//
//  File.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

struct ApplePayReceiptGenerator: ReceiptGenerator {
    
    func generateReceipt(transactionId: String, amount: Double, date: Date) -> Receipt {
        return Receipt(amount: amount,
                       date: date,
                       transactionId: transactionId,
                       note:  "ApplePay receipt for transaction: \(transactionId)")
    }
    
}
 
