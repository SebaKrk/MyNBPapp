//
//  RootFeatureTCA+Path.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture

extension RootFeatureTCA {
    
    @Reducer(state: .equatable)
    enum Path {
        case sandBoxA(SandBoxA)
        case sandBoxB(SandBoxB)
//        case sandBoxC(SandBoxC)
    }
}
