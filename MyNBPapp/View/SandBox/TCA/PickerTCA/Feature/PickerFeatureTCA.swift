//
//  PickerFeatureTCA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import ComposableArchitecture
import DataModels
import SwiftUI

@Reducer
struct PickerFeatureTCA {
    
    // MARK: - Properties
    
    let service: PickerService
    
    // MARK: - Reducer
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            
            switch action {
                
                /// uaktualnij wybrany Okres w momencie zmiany w  "Segmented Picker"
            case let .selectedPeriodChange(period):
                state.selectedPeriod = period
                return .none
                
                /// uaktualnij stan Okresu kiedy zostanie pobrany
            case let .updatePeriods(periods):
                state.periods = periods
                return .none
                
                /// uaktualnij stan "Giełda/wymiana"
            case let .updateExchangeData(exchange):
                state.exchange = exchange
                dump(exchange)
                return .none
                
                /// Jeśli jest wybrany okres to pobierz dane z wskazanym Okresie i przekaz wynik
            case .view(.fetchButtonTapped):
                return .run { [period = state.selectedPeriod] send in
                    guard let selectedPeriod = period else { return }
                    
                    let data = try await service.fetchDataFormNBP(selectedPeriod)
                    await send(.updateExchangeData(data))
                }
                    
                /// pobierz dane odnośnie Okresu widok się pojawi na ekranie
            case .view(.vieDidAppear):
                return .run { send in
                    let periods = service.getPeriods()
                    await send(.updatePeriods(periods))
                }
            }
        }
    }
    
}
