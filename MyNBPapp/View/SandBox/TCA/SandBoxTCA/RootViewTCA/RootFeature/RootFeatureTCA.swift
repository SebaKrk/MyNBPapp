//
//  RootFeatureTCA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/09/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RootFeatureTCA {
    
    typealias StackActionOf<R: Reducer> = StackAction<R.State, R.Action>
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                /// PATH
            case let .path(action):
                switch action {
                case .element(id: _, action: .sandBoxA(.screenButtonTapped)):
                    state.path.append(.sandBoxA(SandBoxA.State()))
                    return .none
                case .element(id: _, action: .sandBoxB(.screenButtonTapped)):
                    state.path.append(.sandBoxB(SandBoxB.State()))
                    return .none
                    
                default:
                    return .none
                }
                
            case .goToViewAAA:
                state.path.append(.sandBoxA(SandBoxA.State()))
                state.path.append(.sandBoxA(SandBoxA.State()))
                state.path.append(.sandBoxA(SandBoxA.State()))
                return .none
                
            case .starButtonTapped:
                state.destination = .openNewScreen(SandBoxStarFeature.State())
                return .none
                
                // case .popToRoot:
                // state.path.removeAll()
                // return .none
            case .destination(_):
                return .none
                
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
        // Scope(state: \.sandBoxCFeature, action: \.sandBoxCFeature) {
        //  SandBoxC()
        // }
    }
    
}
