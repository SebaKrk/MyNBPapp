//
//  ScreenA.swift
//  MyNBPapp
//
//  Created by Sebastian Ściuba on 28/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenA {
    
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

struct ScreenAView: View {
    
    let store: StoreOf<ScreenA>
    
    var body: some View {
        Section {
            NavigationLink(
                "Go to screen A",
                state: RootFeature.Path.State.screenA(ScreenA.State())
            )
        }
            .navigationTitle("Screen A")
    }
}
