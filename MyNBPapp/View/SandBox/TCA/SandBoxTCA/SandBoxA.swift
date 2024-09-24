//
//  SandBoxA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/09/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SandBoxA {
    
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }
    
    enum Action {
        case screenButtonTapped
        case incrementButtonTapped
        case decrementedButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .screenButtonTapped:
                return .none

            case .incrementButtonTapped:
                state.count += 1
                return .none
                
            case .decrementedButtonTapped:
                state.count -= 1
                return .none
            }
        }
    }
}

struct SandBoxViewA: View {
    
    let store: StoreOf<SandBoxA>
    
    var body: some View {
        Form {
            HStack {
                Text("\(store.count)")
                Spacer()
                Group {
                    buttonAction("minus", action: .decrementedButtonTapped)
                    buttonAction("plus", action: .incrementButtonTapped)
                }
                .buttonStyle(.borderless)
            }
        }
        .navigationTitle("SandBox screen A")
    }
    
    @ViewBuilder
    private func buttonAction(_ image: String, action: SandBoxA.Action) -> some View {
        Button {
            store.send(action)
        } label: {
            Image(systemName: image)
        }
    }
    
}

