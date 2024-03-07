//
//  MainView2.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 07/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CurrencyTableFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var selectedCurrency: MainCurrencyState = .euro
        
        var selectedTab: CurrencyTransactionType = .average
        
    }
    
    @CasePathable
    enum Action: ViewAction {
        
        case selectedCurrencyTabChange(MainCurrencyState)
        
        case selectedTabChange(CurrencyTransactionType)
        
        case view(View)
        
        enum View {}
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedCurrencyTabChange(selectedCurrency):
                state.selectedCurrency = selectedCurrency
                return .none
                
            case let .selectedTabChange(selectedTab):
                state.selectedTab = selectedTab
                return .none
                
            default: return .none
            }
        }
    }
    
}


@ViewAction(for: CurrencyTableFeature.self)
struct CurrencyTableView: View {
    
    @Bindable var store: StoreOf<CurrencyTableFeature>

    init() {
        self.store = Store(initialState: CurrencyTableFeature.State(), reducer: { CurrencyTableFeature() })
    }
    
    var body: some View {
        
        NavigationStack {
            Divider()
            HStack {
                currencyRateBox
                    .padding()
                currencyTableBox
                    .padding()
            }
            Spacer()
            
        }
        
    }
    
    @ViewBuilder
    var currencyRateBox: some View {
        GroupBox {
            Text("")
                .frame(height: 300)
                
        } label: {
            currencyRatePicker
        }
    }
    
    
    @ViewBuilder
    var currencyTableBox: some View {
        GroupBox {
            Text("")
                .frame(height: 300)
            
        } label: {
            currencyPicker
        }
        .frame(width: 350)
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
    var currencyPicker: some View {
        Picker("Currency picker", selection: $store.selectedTab.sending(\.selectedTabChange)) {
            ForEach(CurrencyTransactionType.allCases, id: \.self) {  item in
                Text(item.title)
                    .tag(item)
            }
        }
        .pickerStyle(.segmented)
    }
}


enum CurrencyTransactionType: Equatable, CaseIterable {
    
    case average
    
    case purchase
    
    case sale
    
    var title: String {
        switch self {
        case .average: return "Średni"
        case .purchase: return "Kupno"
        case .sale: return "Sprzedaż"
        }
    }
}

enum MainCurrencyState: Equatable, CaseIterable {
    
    case euro
    
    case dolar
    
    case funt
    
    case jen
    
    var title: String {
        switch self {
        case .euro: return "eur"
        case .dolar: return "usd"
        case .funt: return "gbp"
        case .jen: return "jpy"
        }
    }
}
