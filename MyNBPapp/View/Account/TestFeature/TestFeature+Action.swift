//
//  TestFeature+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import Foundation

extension TestFeature {
    
    @CasePathable
    enum Action: ViewAction {
        
        case view(View)
        
        enum View {
            case userTapedTestButton
        }
    }
}
