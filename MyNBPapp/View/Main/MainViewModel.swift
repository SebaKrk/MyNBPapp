//
//  MainViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import MonumentKit
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var nbp = MonumentData.nbp
    
}
