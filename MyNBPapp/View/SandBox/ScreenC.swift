//
//  ScreenC.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenC {
    
    @ObservableState
    struct State: Equatable {
        @Presents var contactFeature: ContactsFeature.State?
        
        var isContactactViewPresented: Bool = false
    }
    
    enum Action {
        case contactButtonTapped
        case contactSheetPresented
        case contactFeature(PresentationAction<ContactsFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .contactButtonTapped:
                return .run { send in
                    await send(.contactSheetPresented)
                }
                
            case .contactSheetPresented:
                state.contactFeature = .init()
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$contactFeature, action: \.contactFeature) {
            ContactsFeature()
        }
    }
    
}

struct ScreenCView: View {
    
    @Bindable var store: StoreOf<ScreenC>
    
    var body: some View {
        Button {
            store.send(.contactButtonTapped)
        } label: {
            Text("Open Contact Sheet")
        }
        .navigationTitle("Screen C")
        
        .sheet(item: $store.scope(state: \.contactFeature, action: \.contactFeature)) { store in
            ContactsView(store: store)
        }
    }
    
}


