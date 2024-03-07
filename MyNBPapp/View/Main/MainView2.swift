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
        
        var selectedTab: MainCurrencyState = .euro
    }
    
    @CasePathable
    enum Action: ViewAction {
        
        case selectedTabChange(MainCurrencyState)
        case view(View)
        
        enum View {
            
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            default: return .none
            }
        }
    }
    
}


@ViewAction(for: CurrencyTableFeature.self)
struct CurrencyTableView: View {
    
    //@Perception.Bindable
//    @Perception.Bindable 
    var store: StoreOf<CurrencyTableFeature>

    init() {
        self.store = Store(initialState: CurrencyTableFeature.State(), reducer: { CurrencyTableFeature() })
    }
    
    var body: some View {
        
        NavigationStack {
            currencyPicker
        }
        
    }
    
    @ViewBuilder
    var currencyPicker: some View {
        Picker("Currency picker", selection: $store.selectedTab.sending(\.selectedTabChange)) {
            ForEach(MainCurrencyState.allCases, id: \.self) {  item in
                Text(item.title)
                    .textCase(.uppercase)
                    .tag(item.title)
            }
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
    
    var iconName: String {
        switch self {
        case .euro: return "unia"
        case .dolar: return "stany"
        case .funt: return "brytania"
        case .jen: return "japonia"
        }
    }
}
