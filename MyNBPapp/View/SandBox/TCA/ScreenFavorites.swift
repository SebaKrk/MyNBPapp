//
//  ScreenFavorites.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/06/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenFavorites {
    
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

struct FavoritesScreenView: View {
    
    let store: StoreOf<ScreenFavorites>
    
    var body: some View {
        Text("FavoritesScreenView")
            .toolbar {
                toolbarButton
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
