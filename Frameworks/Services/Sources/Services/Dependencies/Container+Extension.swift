//
//  Container+Extension.swift
//
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Factory
import Foundation

extension Container {
    
    public var nbpService: Factory<NBPService> {
        Factory(self) { DefaultNBPService() }.shared
    }
    
}
