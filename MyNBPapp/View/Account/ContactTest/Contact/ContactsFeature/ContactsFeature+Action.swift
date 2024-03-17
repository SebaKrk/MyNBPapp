//
//  ContactsFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

///  `ContactsFeature+Action`
extension ContactsFeature {
    
    @CasePathable
    enum Action {
        
        case addButtonTapped
        
        case deleteButtonTapped(id: Contact.ID)
        
        case destination(PresentationAction<Destination.Action>)
        
        case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
        
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
        
    }
    
}
