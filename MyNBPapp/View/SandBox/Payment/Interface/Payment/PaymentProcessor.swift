//
//  PaymentProcessor.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

protocol PaymentProcessor {
    func processPayment(amount: Double)
}
