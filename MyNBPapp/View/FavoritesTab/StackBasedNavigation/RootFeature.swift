//
//  RootFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Ściuba on 22/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct RootFeature {
    
    typealias StackActionOf<R: Reducer> = StackAction<R.State, R.Action>
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var mainList = MainListFeature.State()
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case firstContainer(ContainerFeature)
        case secondContainer(SecondContainerFeature)
    }
    
    @CasePathable
    enum Action {
        case path(StackActionOf<Path>)
        case mainList(MainListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            default: .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}


struct RootView: View {
    
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            MainListView(store: store.scope(state: \.mainList, action: \.mainList))
        } destination: { store in
            switch store.case {
            case .firstContainer(let store):
                ContainerView(store: store)
            case .secondContainer(let store):
                SecondContainerView(store: store)
            }
            
        }
    }
    
}

@Reducer
struct MainListFeature {
    
    @ObservableState
    struct State {
    }
    
    enum Action {
        case barButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .barButtonTapped:
                print("Button tapped")
                return .none
            }
        }
    }
    
}

struct MainListView: View {
    
    @Bindable var store: StoreOf<MainListFeature>
    
    var body: some View {
        List {
            Section {
                NavigationLink(state: RootFeature.Path.State.firstContainer(.init())) {
                    Text("Label: Test 1 - container")
                }
                NavigationLink(state: RootFeature.Path.State.secondContainer(.init())) {
                    Text("Label: Test 2 - second container")
                }
            } header: {
                Text("TEST")
            }
        }
        .navigationTitle("MainListView")
        .toolbar {
            Button {
                store.send(.barButtonTapped)
            } label: {
                Text("Button")
            }
        }
    }
}


@Reducer
struct ContainerFeature {
    
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action {
        case menuButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .menuButtonTapped:
                print("menuButtonTapped")
            return .none
            }
        }
    }
    
}

struct ContainerView: View {
    
    @Bindable var store: StoreOf<ContainerFeature>
    
    var body: some View {
        List {
            Text("Test2")
        }
        .navigationTitle("Container View")
        .toolbar {
            Button {
                store.send(.menuButtonTapped)
            } label: {
                Text("menu")
            }
        }
    }
}

@Reducer
struct SecondContainerFeature {
    
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action {
        case menuButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .menuButtonTapped:
                print("menuButtonTapped")
            return .none
            }
        }
    }
    
}

struct SecondContainerView: View {
    
    @Bindable var store: StoreOf<SecondContainerFeature>
    
    var body: some View {
        List {
            Text("Test3")
        }
        .navigationTitle("Second Container View")
        .toolbar {
            Button {
                store.send(.menuButtonTapped)
            } label: {
                Text("menu")
            }
        }
    }
}
