//
//  ContactDetailFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `ContactDetailFeature+Action`
extension ContactDetailFeature {
    
    @CasePathable
    enum Action {
        case alert(PresentationAction<Alert>)
        
        case delegate(Delegate)
        
        case deleteButtonTapped
        
        enum Alert {
            case confirmDeletion
        }
        
        enum Delegate {
            case confirmDeletion
        }
    }
    
}
