//
//  AddContactFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `AddContactFeature+Action`
extension AddContactFeature {
    
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
    
}
