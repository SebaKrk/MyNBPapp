//
//  ScreenB.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenB {
    
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementedButtonTapped
        case close
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .decrementedButtonTapped:
                state.count -= 1
                return .none
            default:
                return .none
            }
        }
    }
}

struct ScreenBView: View {
    
    let store: StoreOf<ScreenB>
    
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
            
            Section {
                NavigationLink(
                    "Go to screen B",
                    state: RootFeature.Path.State.screenB(ScreenB.State())
                )
            }
        }
        .toolbar {
            popToRootButton
        }
        .navigationTitle("Screen B")
    }
    
    @ViewBuilder
    private func buttonAction(_ image: String, action: ScreenB.Action) -> some View {
        Button {
            store.send(action)
        } label: {
            Image(systemName: image)
        }
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            HStack {
                popToRootButton
            }
        }
    }
    
    @ViewBuilder
    var popToRootButton: some View {
        Button {
            store.send(.close)
        } label: {
            Image(systemName: "xmark")
        }
    }
    
}
