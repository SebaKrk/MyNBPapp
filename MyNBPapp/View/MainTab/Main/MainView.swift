//
//  MainView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 07/03/2024.
//

import Commons
import ComposableArchitecture
import SwiftUI

@ViewAction(for: MainFeature.self)
struct MainView: View {
    
    // MARK: - Environments
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // MARK: - Properties
    
    @Bindable var store: StoreOf<MainFeature>
    
    // MARK: - Lifecycle
    
    init() {
        self.store = Store(initialState: MainFeature.State(), reducer: { MainFeature() })
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                if horizontalSizeClass  == .compact {
                    VStack {
                        Divider()
                        currencyRateBox
                        currencyTableBox
                        currencyConverter
                        Spacer()
                    }
                } else {
                    VStack {
                        Divider()
                        HStack {
                            currencyRateBox
                            currencyTableBox
                        }
                        currencyConverter
                        Spacer()
                    }
                }
            }
            .toolbar {
                toolbarButton
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        } destination: { store in
            CurrencyRateDetailView(store: store)
        }
        .onAppear {
            send(.viewDidAppear)
        }
    }
    
    // MARK: - Subview
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                ForEach(GlobalCurrencySymbols.allCases, id:\.self) { item in
                    Button {
                        send(.selectedCurrencySymbolChange(item))
                    } label: {
                        Label(item.title, systemImage: item.sfSymbol)
                    }
                }
            } label: {
                Text(store.selectedCurrencySymbol.title)
            }
        }
    }
        
    @ViewBuilder
    var currencyRateBox: some View {
        GroupBox {
            HStack {
                MarketRateView()
                Text(store.selectedCurrency.title)
            }
            .frame(height: 300)
        } label: {
            currencyRateBar
        }
    }
    
    @ViewBuilder
    var currencyRateBar: some View {
        HStack {
            currencyRatePicker
            Spacer()
            expandButton
        }
    }
    
    @ViewBuilder
    var expandButton: some View {
        NavigationLink(state: CurrencyRateDetailFeature.State()) {
            Image(systemName: "arrow.down.left.arrow.up.right")
        }
    }

    @ViewBuilder
    var currencyRatePicker: some View {
        Picker("currency rate picker", selection: $store.selectedCurrency.sending(\.selectedCurrencyTabChange)) {
            ForEach(MainCurrencyState.allCases, id: \.self) { item in
                Text(item.title)
                    .textCase(.uppercase)
                    .tag(item)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 200)
    }
    
    @ViewBuilder
    var currencyTableBox: some View {
        GroupBox {
            Text(store.selectedTransitionTab.title)
                .frame(height: 300)
        } label: {
            currencyPicker
        }
        .frame(width: 350)
    }
    
    @ViewBuilder
    var currencyPicker: some View {
        Picker("Currency picker", selection: $store.selectedTransitionTab.sending(\.selectedTabChange)) {
            ForEach(CurrencyTransactionType.allCases, id: \.self) {  item in
                Text(item.title)
                    .tag(item)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    var currencyConverter: some View {
        GroupBox {
            CurrencyConverterView(store: store.scope(state: \.currencyConverter, action: \.currencyConverter))
                .frame(height: 250)
        } label: {
            Label("Currency converter", systemImage: "plus.forwardslash.minus")
        }
    }
    
}
