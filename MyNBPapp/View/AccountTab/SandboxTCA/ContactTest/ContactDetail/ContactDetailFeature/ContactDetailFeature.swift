//
//  ContactDetailFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation


/// `ContactDetailFeature+Reducer
@Reducer
struct ContactDetailFeature {
    
    // MARK: - Dependency
    @Dependency(\.dismiss) var dismiss
    
    // MARK: - Reducer
    
    var body: some ReducerOf<Self> {
      Reduce { state, action in
        switch action {
        case .alert(.presented(.confirmDeletion)):
          return .run { send in
            await send(.delegate(.confirmDeletion))
            await self.dismiss()
          }
            
        case .alert:
          return .none
            
        case .delegate:
          return .none
            
        case .deleteButtonTapped:
          state.alert = .confirmDeletion
          return .none
        }
      }
      .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
  static let confirmDeletion = Self {
    TextState("Are you sure?")
  } actions: {
    ButtonState(role: .destructive, action: .confirmDeletion) {
      TextState("Delete")
    }
  }
}
