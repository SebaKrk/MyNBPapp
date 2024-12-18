//
//  PaymentView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/09/2024.
//

import SwiftUI

struct PaymentView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: PaymentViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack {
            switch viewModel.paymentState {
            case .selection:
                selectionView
            case .processing:
                processingView
            case .success:
                successView
            case .failed:
                failedView
            }
        }
        .sheet(isPresented: $viewModel.showReceipt) {
              if let receipt = viewModel.receipt {
                  VStack(alignment: .leading) {
                      Text("Rachunek:")
                          .font(.headline)
                      Text("Kwota: \(receipt.amount, specifier: "%.2f") zł")
                      Text("Data: \(receipt.date, formatter: viewModel.dateFormatter)")
                      Text("ID transakcji: \(receipt.transactionId)")
                  }
                  .padding()
                  .foregroundColor(.green)
              }
          }
        .padding()
    }
    
    // MARK: - SubView
    
    private var selectionView: some View {
        VStack {
            Text("Kwota do zapłaty: \(viewModel.inputAmount)")
            ///Text("Kwota do zapłaty: \(viewModel.receipt?.amount ?? 0, specifier: "%.2f") zł")
                .font(.footnote)
                .padding()
            
            TextField("Kwota", text: $viewModel.inputAmount)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            PaymentActionButton(title: "Zrealizuj płatność",
                                color: BlueColor()) {
                if let amount = Double(viewModel.inputAmount) {
                    processPayment(amount)
                }
            }
            .padding()
        }
    }
    
    private var processingView: some View {
        ProgressView("Przetwarzanie płatności...")
    }
    
    private var successView: some View {
        VStack {
            Text("Płatność zakończona sukcesem!")
                .font(.headline)
                .foregroundColor(.green)
                .padding()
            PaymentActionButton(title: "Pokaż Rachunek",
                                color: GreenColor()) {
                viewModel.showReceipt = true
            }
            .padding()
        }
    }
    
    private var failedView: some View {
        VStack {
            if let error = viewModel.paymentError {
                Text("Błąd płatności: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            }
            PaymentActionButton(title: "Spróbuj onownie",
                                color: RedColor()) {
                viewModel.retryPayment()
            }
            .padding()
        }
    }
    
    // MARK: - Methods
    
    private func processPayment(_ amount: Double) {
        Task {
            await viewModel.processPayment(amount: amount)
        }
    }
    
}
