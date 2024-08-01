//
//  ScreenContact.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 31/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ScreenContact {
    
    @Dependency(\.uuid) var uuid
    
    @Reducer(state: .equatable)
    enum Destination {
        case addContactCard(AddContactFeature)
    }
    
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        
        @Presents var destination: Destination.State?
        
    }

    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addContactCard(
                    AddContactFeature.State(
                        contact: Contact(id: self.uuid(), name: "")
                    )
                )
                return .none
                
            case let .destination(.presented(.addContactCard(.delegate(.saveContact(contact))))):
                state.contacts.append(contact)
                return .none
            
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

struct ScreenContactView: View {
    
    @Bindable var store: StoreOf<ScreenContact>
    
    var body: some View {
        List {
            ForEach(store.contacts) { contact in
                Text(contact.name)
            }
            .swipeActions {
                deletedButton
                favoriteButton
            }
        }
        .toolbar {
            toolbarButton
        }
        .sheet(
          item: $store.scope(state: \.destination?.addContactCard, action: \.destination.addContactCard)
        ) { addContactStore in
          NavigationStack {
            AddContactView(store: addContactStore)
          }
        }
   
    }
    
    @ToolbarContentBuilder
    var toolbarButton: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            HStack {
                addContactButton
            }
        }
    }
    
    @ViewBuilder
    var addContactButton: some View {
        Button {
            store.send(.addButtonTapped)
        } label: {
            Image(systemName: "plus")
        }
    }
    
    @ViewBuilder
    var favoriteButton: some View {
        Button {
            
        } label: {
            Image(systemName: "star")
        }
    }
    
    @ViewBuilder
    var deletedButton: some View {
        Button(role: .destructive) {
            
        } label: {
            Image(systemName: "trash")
        }

    }
}
