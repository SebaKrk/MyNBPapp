//
//  PaymentFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import Foundation

protocol PaymentFactory {
    func createPaymentProcessor() -> PaymentProcessor
    func createReceiptGenerator() -> ReceiptGenerator
}
 
// PaymentSystem
//│
//├── /Factories
//│   ├── PaymentFactory.swift
//│   ├── PayPalFactory.swift
//│   └── ApplePayFactory.swift
//│
//├── /Processors
//│   ├── PaymentProcessor.swift
//│   ├── PayPalPaymentProcessor.swift
//│   └── ApplePayPaymentProcessor.swift
//│
//├── /Receipts
//│   ├── ReceiptGenerator.swift
//│   ├── PayPalReceiptGenerator.swift
//│   └── ApplePayReceiptGenerator.swift
//│
//└── /Views
//    ├── PaymentView.swift
//    └── AppView.swift
