//
//  ScreenC.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenC {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        case screenButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .screenButtonTapped:
              return .none
            }
        }
    }
}

struct ScreenCView: View {
    
    let store: StoreOf<ScreenC>
    
    var body: some View {
        Section {
            
        }
            .navigationTitle("Screen C")
    }
}
