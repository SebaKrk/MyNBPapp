//
//  PickerFeatureTCA+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 10/12/2024.
//

import ComposableArchitecture
import DataModels

extension PickerFeatureTCA {
    
    @CasePathable
    enum Action: ViewAction {
    
        /// akcja odpowiedzialna za uaktualnienie stan u"Giełda/wymiana"
        case updateExchangeData(Exchange)
        
        /// akcja odpowiedzialna za uaktualnienie stanu "Okresu" kiedy zostanie pobrany
        case updatePeriods(Periods)
        
        /// akcja odpowiedzialna za zmianę "Okresu" np w segmented period
        case selectedPeriodChange(Period?)
        
        /// widok
        case view(View)
        
        enum View {
            
            /// akcja odpowiedzialna za obsłużenie akcji w widoku - pobranie danych po naciśnięciu przycisku
            case fetchButtonTapped
            
            /// akcja odpowiedzialna za obsłużenie podczas pojawienia się widoku
            case vieDidAppear
        }
    }
}
