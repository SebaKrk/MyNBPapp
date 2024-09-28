//
//  RootViewTCA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/09/2024.
//

import ComposableArchitecture
import SwiftUI

struct RootViewTCA: View {
    
    @Bindable var store: StoreOf<RootFeatureTCA>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                sectionOne
                    
                sectionTwo
                ///sectionThree
                sectionFour
            }
            .navigationTitle("Root")
            .toolbar { starRootButton }
        } destination: { store in
            switch store.case {
            case let .sandBoxA(store):
                SandBoxViewA(store: store)
            case let .sandBoxB(store):
                SandBoxBView(store: store)
            }
        }
        .sheet(item: $store.scope(state: \.destination?.openNewScreen,
                                  action:  \.destination.openNewScreen)) { store in
            SandBoxStarView(store: store)
        }
    }
    
    @ViewBuilder
    var sectionOne: some View {
        Section {
            NavigationLink(state: RootFeatureTCA.Path.State.sandBoxA(SandBoxA.State())) {
                Image(systemName: "arrow.right")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionTwo: some View {
        Section {
            Button {
                store.send(.goToViewAAA)
            } label: {
                Text("Go to A → A → A")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionThree: some View {
        Section {
            Button {
                //store.send(.popToRoot)
            } label: {
                Text("pop to root")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionFour: some View {
        Section {
            NavigationLink(state: RootFeatureTCA.Path.State.sandBoxB(SandBoxB.State())) {
                Text("Go to → B")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var starRootButton: some View {
        Button {
            store.send(.starButtonTapped)
        } label: {
            Image(systemName: "star")
        }
    }
}

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
                
//            case .popToRoot:
//                state.path.removeAll()
//                return .none
            case .destination(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
    }
    
}


extension RootFeatureTCA {
    
    @CasePathable
    enum Action {
        
        case path(StackActionOf<Path>)
        
        case goToViewAAA
        
        //case gotoViewB
        
        case destination(PresentationAction<Destination.Action>)
        
        case starButtonTapped
        
        //case popToRoot
        
    }
}

extension RootFeatureTCA {
 
    @ObservableState
    struct State: Equatable {
        
        var path = StackState<Path.State>()
        
        @Presents
        var destination: Destination.State?
    }
}

extension RootFeatureTCA {
    
    @Reducer(state: .equatable)
    enum Path {
        case sandBoxA(SandBoxA)
        case sandBoxB(SandBoxB)
    }
}

extension RootFeatureTCA {
    @Reducer(state: .equatable)
    enum Destination {
        case openNewScreen(SandBoxStarFeature)
    }
}
