//
//  RootFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RootFeature {
    
    typealias StackActionOf<R: Reducer> = StackAction<R.State, R.Action>
    
    @Reducer(state: .equatable)
    enum Path {
        case screenA(ScreenA)
        case screenB(ScreenB)
        case screenC(ScreenC)
        case contact(ContactsFeature)
        case screenContact(ScreenContact)
        
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case openScreenFavorites(ScreenFavorites)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .goToAAAButtonTapped:
                state.path.append(.screenA(ScreenA.State()))
                state.path.append(.screenA(ScreenA.State()))
                state.path.append(.screenB(ScreenB.State()))
                return .none
                
            case let.path(action):
                switch action {
                case .element(id: _, action: .screenA(.screenButtonTapped)):
                    state.path.append(.screenA(ScreenA.State()))
                    return .none
                    
                case .element(id: _ , action: .screenB(.close)):
                    return .run { send in
                        await send(.popToRoot)
                    }
                    
                default:
                  return .none
                }
                
            case .popToRoot:
                state.path.removeAll()
                return .none
                
            case .favoritesButtonTapped:
                state.destination = .openScreenFavorites(ScreenFavorites.State())
                return .none
            case .destination(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
    }
    
}
