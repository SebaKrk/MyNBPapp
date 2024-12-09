//
//  DestinationTestTCA.swift
//  Rybka
//
//  Created by Sebastian Sciuba on 07/12/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TestFeatureA {
    
    // MARK: - Action A
    
    @CasePathable
    enum Action: ViewAction, BindableAction {
        
        case binding(BindingAction<State>)
        
        case view(View)
        
        enum View {
            case viewDidAppearA
            case didPressedButtonGoToViewB
        }
        
        case destination(PresentationAction<Destination.Action>)
    }
    
    // MARK: - State A
    
    @ObservableState
    struct State: Equatable {
        
        var userName: String = "Brak"
        
        @Presents var destination: Destination.State?
        
    }
    
    // MARK: - Destination
    @Reducer(state: .equatable)
    enum Destination {
        case openViewB(TestFeatureB)
    }
    
    // MARK: - Reducer A
    var body: some Reducer<State, Action> {
        CombineReducers {
            BindingReducer()
            Reduce { state, action in
                
                switch action {
                case .view(.viewDidAppearA):
                    print("ViewDidApper A")
                    return  .none
                    
                case .view(.didPressedButtonGoToViewB):
                    print("didPressedButtonGoToViewB")
                    state.destination = .openViewB(TestFeatureB.State())
                    return .none
                    
                case let .destination(.presented(.openViewB(.delegate(.changeUserName(name))))):
                    print("change user name form Feature B")
                    state.userName =  name
                    return  .none
                    
                default: return .none
                }
            }
            .ifLet(\.$destination, action: \.destination)
        }
    }
}

// MARK: - Test View A

@ViewAction(for: TestFeatureA.self)
struct TestViewA: View {
    
    @Bindable var store: StoreOf<TestFeatureA>
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("TestView A")
                Spacer()
                Text("UserName: \(store.userName)")
                Spacer().frame(height: 20)
                destinationButton
                Spacer()
            }
            .onAppear {
                send(.viewDidAppearA)
            }
        }
        .sheet(item: $store.scope(state: \.destination?.openViewB,
                                  action: \.destination.openViewB)) { store in
            NavigationStack {
                TestViewB(store: store)
            }
        }
        
    }
    
    @ViewBuilder
    private var destinationButton: some View {
        Button {
            send(.didPressedButtonGoToViewB)
        } label: {
            Text("GO A -> B")
        }
    }
}

// MARK: - Feature B

@Reducer
struct TestFeatureB {
    
    @Dependency(\.dismiss) var dismiss
    
    // MARK: - Action B
    @CasePathable
    enum Action: ViewAction, BindableAction {
        
        case binding(BindingAction<State>)
        
        //case changeName
        
        case view(View)
        
        enum View {
            case viewDidAppear
            case cancelButtonTapped
            case changeUserName
        }
        
        // MARK: - Delegate
        
        /// Actions to communicate with parent features or modules.
        case delegate(DelegateAction)
        
        enum DelegateAction {
            
            case changeUserName(String)
        }
    }
    
    // MARK: - State B
    @ObservableState
    struct State: Equatable {
        
        var newUserName: String = "Sebastian"
    }
    
    // MARK: - Reducer B
    var body: some Reducer<State, Action> {
        CombineReducers {
            BindingReducer()
            Reduce { state, action in
                switch action {
                    
                case .view(.viewDidAppear):
                    print("ViewDidApper B")
                    return  .none
                    
                case .view(.cancelButtonTapped):
                    return .run { send in
                        await self.dismiss()
                    }
                    
                case .view(.changeUserName):
                    print("view action button to change user name")
                    return .run { [name = state.newUserName] send in
                        await send(.delegate(.changeUserName(name)))
                        await self.dismiss()
                    }
                    
                case .binding(_):
                    return .none
                case .delegate(_):
                    return .none
                }
                
            }
        }
    }
}

// MARK: - Test View B

@ViewAction(for: TestFeatureB.self)
struct TestViewB: View {
    
    @Bindable var store: StoreOf<TestFeatureB>
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("TestView B")
                Spacer()
                changeUserNameButton
                Spacer()
            }
            .toolbar {
                toolbarButton
            }
        }
        
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                send(.cancelButtonTapped)
            } label: {
                Text("cancel")
            }
        }
    }
    
    @ViewBuilder
    var changeUserNameButton: some View {
        Button {
            send(.changeUserName)
        } label: {
            Text("Change User Name")
        }
    }
}
