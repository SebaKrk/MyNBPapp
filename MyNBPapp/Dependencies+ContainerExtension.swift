//
//  Dependencies+ContainerExtension.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Factory
import Services
import Foundation

extension Container {
    
    public var nbpService: Factory<NBPService> {
        Factory(self) { DefaultNBPService() }.shared
    }
    
    public var pickerRepository: Factory<PickerRepository> {
        Factory(self) { DefaultPickerRepository() }.shared
    }
    
}
