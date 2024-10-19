//
//  SandBoxC.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

//ElementData

import ComposableArchitecture
import SwiftUI

@Reducer
struct SandBoxC {
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .sandBoxButtonC:
                return .none
                
            default: return .none
            }
        }
    }
}

extension SandBoxC {
    
    @CasePathable
    enum Action {
        case sandBoxButtonC
    }
    
}

extension SandBoxC {
    
    @ObservableState
    struct State: Equatable {
        var element: ElementData?
    }
    
}


struct SandBoxViewC: View {
    
    let store: StoreOf<SandBoxC>
    
    var body: some View {
//        if let element = store.element {
//            Text(element.title)
//        } else {
//            Text("Bład")
//        }
//        
        Text("Widok C")
    }
}

