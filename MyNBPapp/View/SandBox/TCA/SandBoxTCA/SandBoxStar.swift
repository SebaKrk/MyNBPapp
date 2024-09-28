//
//  SandBoxStar.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture
import SwiftUI 

@Reducer
struct SandBoxStarFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        case cancelButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .cancelButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
            }
        }
    }
    
}

struct SandBoxStarView: View {
    
    let store: StoreOf<SandBoxStarFeature>
    
    var body: some View {
        NavigationStack {
            Text("SandBoxStarView")
                .toolbar {
                    toolbarButton
                }
        }
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                store.send(.cancelButtonTapped)
            } label: {
                Text("cancel")
            }
        }
    }
}

