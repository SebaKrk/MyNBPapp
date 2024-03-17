//
//  AddContactFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import SwiftUI

/// `AddContactFeature+Reducer`
@Reducer
struct AddContactFeature {
    
    // MARK: Dependency
    @Dependency(\.dismiss) var dismiss
    
    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            case .cancelButtonTapped:
                return .run { send in
                    await self.dismiss()
                }
                
            case .delegate:
               return .none
                
            case .saveButtonTapped:
                return .run { [contact = state.contact] send in
                    await send(.delegate(.saveContact(contact)))
                    await self.dismiss()
                }
                
            case let .setName(name):
                state.contact.name = name
                return .none
            }
        }
    }
}
