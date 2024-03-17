//
//  ContactsFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import SwiftUI

/// `ContactsFeature+Reducer`
@Reducer
struct ContactsFeature {
  
    // MARK: - Reducer
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        state.destination = .addContact(
          AddContactFeature.State(
            contact: Contact(id: UUID(), name: "")
          )
        )
        return .none
        
      case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
        state.contacts.append(contact)
        return .none
        
      case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
        state.contacts.remove(id: id)
        return .none
        
      case .destination:
        return .none
        
      case let .deleteButtonTapped(id: id):
        state.destination = .alert(
          AlertState {
            TextState("Are you sure?")
          } actions: {
            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
              TextState("Delete")
            }
          }
        )
        return .none
          
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

