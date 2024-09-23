//
//  PaymentServiceProtocol.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/09/2024.
//

import Foundation

protocol PaymentServiceProtocol {
    func processPayment(amount: Double) async throws -> Receipt
}
