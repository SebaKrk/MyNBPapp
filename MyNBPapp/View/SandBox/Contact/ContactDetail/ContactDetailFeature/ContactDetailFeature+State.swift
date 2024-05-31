//
//  ContactDetailFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `ContactDetailFeature+State`
extension ContactDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        
        @Presents var alert: AlertState<Action.Alert>?
        
        var contact: Contact
        
    }
    
}
