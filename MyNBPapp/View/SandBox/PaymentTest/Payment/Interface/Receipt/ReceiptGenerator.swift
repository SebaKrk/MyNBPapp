//
//  ReceiptGenerator.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

protocol ReceiptGenerator {
    func generateReceipt(transactionId: String, amount: Double, date: Date) -> Receipt
}

 
