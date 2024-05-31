//
//  AddContactFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `AddContactFeature+State`
extension AddContactFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var contact: Contact
        
    }
}
