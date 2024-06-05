//
//  Contact.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/03/2024.
//

import Foundation
import SwiftData


struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}

@Model
class ContactTest {
    @Attribute(.unique) var id: UUID
    var name: String
    var phone: String
    
    init(id: UUID, name: String, phone: String) {
        self.id = id
        self.name = name
        self.phone = phone
    }
}
