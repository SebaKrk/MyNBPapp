//
//  AddContactView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import ComposableArchitecture
import SwiftUI

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
