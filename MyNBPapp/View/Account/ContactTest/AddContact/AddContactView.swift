//
//  AddContactView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AddContactFeature {
    
    @Dependency(\.dismiss) var dismiss
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    @CasePathable
    enum Action {
        
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        
        enum Delegate: Equatable {
          case saveContact(Contact)
        }
    }

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

struct AddContactView: View {
    
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("name", text: $store.contact.name.sending(\.setName))
            Button {
                store.send(.saveButtonTapped)
            } label: {
                Text("Save")
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    store.send(.cancelButtonTapped)
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

#Preview {
  NavigationStack {
    AddContactView(
      store: Store(
        initialState: AddContactFeature.State(
          contact: Contact(
            id: UUID(),
            name: "Blob"
          )
        )
      ) {
        AddContactFeature()
      }
    )
  }
}
