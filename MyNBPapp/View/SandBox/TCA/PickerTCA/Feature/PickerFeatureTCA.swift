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
        
        case updatePeriod(Period)
        
        case updatePeriods(Periods)
        
        case view(View)
        
        enum View {
            
            case fetchPeriodButtonTapped
            case fetchButtonTapped
            
            case vieDidAppear
        }
    }
    
    @ObservableState
    struct State: Equatable {
        
        var exchange: Exchange? = nil
        
        var period: Period? = nil
        
        var periods: Periods? = nil
//        var periods: Periods?
//        var periodState: PeriodsStatePicker = .current
//        var periodState = Periods.currentPeriod(<#T##Period#>)
//        var selectedPeriod: Periods = .currentPeriod(<#T##Period#>)
      
    }
    
    // MARK: - Properties
    
    let service: PickerService
    
    // MARK: - Reducer
    
    var body: some Reducer<State, Action> {
        CombineReducers {
            BindingReducer()
            Reduce { state, action in
                
                switch action {
                
                case let .updatePeriods(periods):
                    state.periods = periods
                    dump(periods)
                    return .none
                    
                case let .updatePeriod(period):
                    state.period = period
                    dump(period)
                    return .none
                    
                case let .updateExchangeData(exchange):
                    state.exchange = exchange
                    dump(exchange)
                    return .none
                
                case .view(.fetchPeriodButtonTapped):
                    return .run { send in
                        let period = service.getPeriod()
                        await send(.updatePeriod(period))
                    }
                    
                case .view(.fetchButtonTapped):
                    return .run { [period = state.period] send in
                        guard let period = period else { return }
                        let data = try await service.fetchDataFormNBP(period)
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

