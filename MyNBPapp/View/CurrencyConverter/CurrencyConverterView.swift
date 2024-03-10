    //
//  CurrencyConverterView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 08/03/2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: CurrencyConverterFeature.self)
struct CurrencyConverterView: View {
    
    @Bindable var store: StoreOf<CurrencyConverterFeature>
    @State var num: Double = 0
    
    var body: some View {
        HStack {
            VStack {
                transitionTypeView
                amountView
                paymentCurrencySelector
            }
            convertedAmountView
        }
    }
    
    @ViewBuilder
    var transitionTypeView: some View {
        HStack {
            Spacer()
            Text("Chcę")
                .textCase(.uppercase)
                .bold()
                .padding()
            transitionTypePicker
        }
    }
    
    @ViewBuilder
    var transitionTypePicker: some View {
        Picker("Sales Picker",selection: $store.selectedTransactionType.sending(\.selectedTransactionTypeChange)) {
            ForEach(TransactionType.allCases, id: \.self) { item in
                Text(item.title)
                    .tag(item)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 420)
        .overlay { createCapsule(440,50) }
        .padding()
    }
    
    @ViewBuilder
    var amountView: some View {
        HStack {
            Spacer()
            amountTextField
            currencySelectView
        }
    }
    
    @ViewBuilder
    private var amountTextField: some View {
        TextField("Wpisz liczbę do przekonwertowania", text: $store.amount.sending(\.convertAmount))
            .keyboardType(.numberPad)
            .frame(width: 290)
            .overlay { createCapsule(300, 50) }
    }
    
    @ViewBuilder
    private var currencySelectView: some View {
        HStack {
            Text(store.currencySelectType.title)
            Spacer()
            Menu {
                ForEach(GlobalCurrencySymbols.allCases, id:\.self) { item in
                    Button {
                        send(.selectedCurrencyType(item))
                    } label: {
                        Text(item.title)
                    }
                }
            } label: {
                Image(systemName: "chevron.down")
            }
        }
        .frame(width: 110)
        .overlay { createCapsule(120, 50) }
        .padding()
    }
    
    @ViewBuilder
    var paymentCurrencySelector: some View {
        HStack {
            Spacer()
            Text(store.selectedTransactionType == .buy ? "Płacę" : "Dostanę")
                .textCase(.uppercase)
                .bold()
                .padding()
            currencyMenu
        }
    }
    
    @ViewBuilder
    var currencyMenu: some View {
        HStack {
            Text(store.paymentCurrencyType.title)
            Spacer()
            Menu {
                ForEach(GlobalCurrencySymbols.allCases, id:\.self) { item in
                    Button {
                        send(.selectedPaymentCurrencyType(item))
                    } label: {
                        Text(item.title)
                    }
                }
            } label: {
                Image(systemName: "chevron.down")
            }
        }
        .frame(width: 420)
        .overlay { createCapsule(440, 50) }
        .padding()
    }
    
    @ViewBuilder
    var convertedAmountView: some View {
        Text(store.convertedAmount ?? 0, format: .number.precision(.fractionLength(3)))
            .frame(width: 300)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
                    .frame(width: 300, height: 250)
            }
    }
        
    @ViewBuilder
    private func  createCapsule(_ width: CGFloat,_ height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray)
            .frame(width: width, height: height, alignment: .center)
    }
    
}

#Preview {
    CurrencyConverterView(store: Store(initialState: CurrencyConverterFeature.State(), reducer: {
        CurrencyConverterFeature()
    }))
}



