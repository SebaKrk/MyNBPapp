//
//  ContactsFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

///  `ContactsFeature+State`
extension ContactsFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var contacts: IdentifiedArrayOf<Contact> = []
        
        @Presents var destination: Destination.State?
        
        var path = StackState<ContactDetailFeature.State>()
        
    }
    
}
