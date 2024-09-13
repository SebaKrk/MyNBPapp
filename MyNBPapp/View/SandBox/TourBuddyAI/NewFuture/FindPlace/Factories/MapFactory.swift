//
//  MapFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI

protocol MapViewFactory {
    
    associatedtype Content: View

    func createMap() -> Content
    
}
