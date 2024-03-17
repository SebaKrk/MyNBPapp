//
//  ContactView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ContactsFeature {
    
    @ObservableState
    struct State: Equatable {
        
        @Presents var addContact: AddContactFeature.State?
        
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    @CasePathable
    enum Action {
        
        case addButtonTapped
        
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
                /// When the “+” button is tapped in the contacts list feature we can now populate the addContact state to represent that the feature should be presented.
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none
                
                /// When the “Cancel” button is tapped inside the “Add Contacts” feature we want to dismiss the feature and do nothing else. This can be accomplished by simply nil-ing out the addContact state.
            //case .addContact(.presented(.cancelButtonTapped)):
//            case .addContact(.presented(.delegate(.cancel))):
//                ///state.addContact = nil
//                return .none
                
                /// When the “Save” button is tapped inside the “Add Contacts” feature we want to not only dismiss the feature, but we also want to add the new contact to the collection of contacts held in ContactsFeature.State.
            //case .addContact(.presented(.saveButtonTapped)):
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                  // guard let contact = state.addContact?.contact
                  // else { return .none }
                ///The application should work exactly as it did before the “delegate action” refactor, but now the child feature can accurately describe what it wants the parent to do rather than the parent make assumptions. There is still room for improvement though. It is very common for a child feature to want to dismiss itself, such as is the case when tapping “Cancel”. It is too cumbersome to create a delegate action just to communicate this to the parent, and so the library comes with a special tool for this.
                state.contacts.append(contact)
                //state.addContact = nil
                return .none
                
            case .addContact:
                return .none
                
            default: return .none
                
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
}

struct ContactsView: View {
    
    @Bindable var store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.contacts) { contact in
                    Text(contact.name)
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
              }
        }
    }
}

#Preview {
    ContactsView(
        store: Store(
            initialState: ContactsFeature.State(
                contacts: [
                    Contact(id: UUID(), name: "Blob"),
                    Contact(id: UUID(), name: "Blob Jr"),
                    Contact(id: UUID(), name: "Blob Sr"),
                ]
            )
        ) {
            ContactsFeature()
        }
    )
}
