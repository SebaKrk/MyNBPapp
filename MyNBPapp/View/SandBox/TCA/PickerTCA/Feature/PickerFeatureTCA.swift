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
    
    @CasePathable
    enum Action: ViewAction, BindableAction {
        
        case binding(BindingAction<State>)
        
        case updateExchangeData(Exchange)
        
        case updatePeriods(Periods)
        
        case selectedPeriodChange(Period?)
        
        case view(View)
        
        enum View {
            
            case fetchButtonTapped
            
            case vieDidAppear
        }
    }
    
    @ObservableState
    struct State: Equatable {
        
        var exchange: Exchange? = nil
    
        var periods: Periods? = nil
        
        var selectedPeriod: Period?
    }
    
    // MARK: - Properties
    
    let service: PickerService
    
    // MARK: - Reducer
    
    var body: some Reducer<State, Action> {
        CombineReducers {
            BindingReducer()
            Reduce { state, action in
                
                switch action {
                    
                case let .selectedPeriodChange(period):
                    state.selectedPeriod = period
                    let test = state.selectedPeriod
                    print(test!)
                    
                    return .none

                case let .updatePeriods(periods):
                    state.periods = periods
                    return .none
                    
                case let .updateExchangeData(exchange):
                    state.exchange = exchange
                    dump(exchange)
                    return .none
                    
                case .view(.fetchButtonTapped):
                    return .run { [period = state.selectedPeriod] send in
                        guard let selectedPeriod = period else { return }
                        
                        let data = try await service.fetchDataFormNBP(selectedPeriod)
                        await send(.updateExchangeData(data))
                    }
                    
                case .view(.vieDidAppear):
                    return .run { send in
                        let periods = service.getPeriods()
                        await send(.updatePeriods(periods))
                    }
                    
                case .binding(_):
                    return .none
                }
            }
        }
    }
    
}
