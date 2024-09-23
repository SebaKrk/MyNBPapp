//
//  PaymentView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import SwiftUI

struct PaymentView: View {
    
    @ObservedObject var viewModel: PaymentViewModel
    
    var body: some View {
        VStack {
            Text("Kwota do zapłaty: \(viewModel.receipt?.amount ?? 0, specifier: "%.2f") zł")
                .font(.footnote)
                .padding()
            TextField("Kwota", text: $viewModel.inputAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                if let amount = Double(viewModel.inputAmount) {
                    processPayment(amount)
                }
            } label: {
                Text("Zrealizuj płatność")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

//            if let receipt = viewModel.receipt {
//                VStack(alignment: .leading) {
//                    Text("Rachunek:")
//                        .font(.headline)
//                    Text("Kwota: \(receipt.amount, specifier: "%.2f") zł")
//                    Text("Data: \(receipt.date, formatter: dateFormatter)")
//                    Text("ID transakcji: \(receipt.transactionId)")
//                }
//                .padding()
//                .foregroundColor(.green)
//            }
            
            if let error = viewModel.paymentError {
                Text("Błąd płatności: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .sheet(isPresented: $viewModel.showReceipt) {
              if let receipt = viewModel.receipt {
                  VStack(alignment: .leading) {
                      Text("Rachunek:")
                          .font(.headline)
                      Text("Kwota: \(receipt.amount, specifier: "%.2f") zł")
                      Text("Data: \(receipt.date, formatter: dateFormatter)")
                      Text("ID transakcji: \(receipt.transactionId)")
                  }
                  .padding()
                  .foregroundColor(.green)
              }
          }
        .padding()
    }
    
    private func processPayment(_ amount: Double) {
        Task {
            await viewModel.processPayment(amount: amount)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
