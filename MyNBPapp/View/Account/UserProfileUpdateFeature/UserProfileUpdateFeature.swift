//
//  UserProfileUpdateFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 06/03/2024.
//

import ComposableArchitecture
import SwiftUI
import Foundation

@Reducer
struct UserProfileUpdateFeature {
    
    /// `UserProfileUpdateFeature+State`
    @ObservableState
    struct State {
        
        var text: String = ""
        var name: String = "sebastian"
        
    }
    
    /// `UserProfileUpdateFeature+Action`
    @CasePathable
    enum Action: ViewAction {
        
        case textChange(String)
        
        case view(View)
        
        enum View { 
            
            case userTapedButton(String)
        }
    }
    
    /// `UserProfileUpdateFeature+Reducer`
    var body: some ReducerOf<Self> {
        CombineReducers {
            Reduce { state, action in
                switch action {
                    
                case let .textChange(newName):
                    state.text = newName
                    return .none
                    
                case let .view(.userTapedButton(newName)):
                    state.name = newName
                    return .none
                }
            }
        }
    }
    
}

@ViewAction(for: UserProfileUpdateFeature.self)
struct UserProfileUpdateFeatureView: View {
    
    @State private var name: String = ""
    @Bindable var store: StoreOf<UserProfileUpdateFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                Spacer()
                userName
                HStack {
                    textFieldData
                    sendButton
                }
                .frame(width: 400)
                Spacer()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Favorites")
        }
    }
    
    @ViewBuilder
    var userName: some View {
        Text(store.name)
            .padding()
    }
    
    @ViewBuilder
    var textFieldData: some View {
        TextField("enter your name", text: $store.text.sending(\.textChange))
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
    }
    
    @ViewBuilder
    var sendButton: some View {
        Button {
            send(.userTapedButton(store.text))
        } label: {
            Label("Send", systemImage: "arrow.up.circle")
                .foregroundStyle(.blue)
        }
        .padding()
    }
}
