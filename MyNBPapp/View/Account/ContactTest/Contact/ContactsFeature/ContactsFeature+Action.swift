//
//  ContactsFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import Foundation

///  `ContactsFeature+Action`
extension ContactsFeature {
    
   enum Action {
       
     case addButtonTapped
       
     case deleteButtonTapped(id: Contact.ID)
       
     case destination(PresentationAction<Destination.Action>)
       
     enum Alert: Equatable {
       case confirmDeletion(id: Contact.ID)
     }
       
   }
    
}
