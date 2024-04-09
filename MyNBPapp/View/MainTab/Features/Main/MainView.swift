//
//  MainView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 07/03/2024.
//

import Commons
import ComposableArchitecture
import DataModels
import Factory
import SwiftUI

@ViewAction(for: MainFeature.self)
struct MainView: View {
    
    // MARK: - Environments
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // MARK: - Dependency
    
    @Injected(\.chartViewFactory) private var viewFactory
    
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
            ContainerRateDetailView(store: store)
        }
        .onAppear {
            send(.viewDidAppear)
        }
    }
    
    // MARK: - Subview
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            HStack {
                chartRangeDate
                globalCurrencySymbolButton
            }
        }
    }
    
    @ViewBuilder
    var globalCurrencySymbolButton: some View {
        Menu {
            globalCurrencySymbolMenu
        } label: {
            Text(store.selectedCurrencySymbol.title)
        }
    }
    
    @ViewBuilder
    var globalCurrencySymbolMenu: some View {
        ForEach(GlobalCurrencySymbols.allCases, id:\.self) { item in
            Button {
                send(.selectedCurrencySymbolChange(item))
            } label: {
                Label(item.title, systemImage: item.sfSymbol)
            }
        }
    }
    
    @ViewBuilder
    var chartRangeDate: some View {
        Menu {
            ForEach(PeriodsCurrencyOption.allCases, id:\.self) { item in
                Button {
                    send(.selectedPeriodChange(item))
                } label: {
                    Text(item.title)
                }
            }
        } label: {
            Image(systemName: "rectangle.grid.2x2")
        }
    }
    
    @ViewBuilder
    var currencyRateBox: some View {
        if let exchange = store.exchange, let cashExchangeRates = store.cashExchangeRates  {
            GroupBox {
                Group {
                    viewFactory.createCurrencyDetailsViews(chart: .exchange,
                                                           exchange: exchange,
                                                           cashExchangeRates: cashExchangeRates,
                                                           selectedPeriod: store.dateForm,
                                                           isExpand: false)
                }
                .frame(height: 300)
            } label: {
                HStack {
                    currencyRateBar(exchange, cashExchangeRates)
                }
            }
        }
    }
    
    @ViewBuilder
    func currencyRateBar(_ dataA: Exchange, _ dataC: [RatesC]) -> some View {
        HStack {
            currencyRatePicker
            Spacer()
            expandButton(dataA, dataC)
        }
    }
    
    @ViewBuilder
    func expandButton(_ dataA: Exchange, _ dataC: [RatesC]) -> some View {
        NavigationLink(state: ContainerRateDetailFeature.State(exchange: dataA,
                                                               cashExchangeRates: dataC,
                                                               selectedPeriod: store.dateForm) ) {
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
        Picker("Currency picker", selection: $store.selectedTransitionTab.sending(\.selectedTabTransactionChange)) {
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

