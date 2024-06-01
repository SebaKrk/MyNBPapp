//
//  ContactsFeature+Destination.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import ComposableArchitecture
import Foundation

/// `ContactsFeature+Destination`
extension ContactsFeature {
    
    @Reducer(state: .equatable)
    enum Destination {
        
        case addContact(AddContactFeature)
        
        case alert(AlertState<ContactsFeature.Action.Alert>)
        
    }
    
}
