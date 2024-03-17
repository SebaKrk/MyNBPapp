//
//  ContactDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct ContactDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var contact: Contact
    
    }
    
    @CasePathable
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            default: return .none
            }
        }
    }
}

struct ContactDetailView: View {
    
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            
        }
        .navigationTitle(Text(store.contact.name))
    }
    
}

#Preview {
  NavigationStack {
    ContactDetailView(
      store: Store(
        initialState: ContactDetailFeature.State(
          contact: Contact(id: UUID(), name: "Blob")
        )
      ) {
          ContactDetailFeature()
      }
    )
  }
}
