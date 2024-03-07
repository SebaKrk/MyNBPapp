//
//  TestView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: TestFeature.self)
struct TestView: View {
    
    let store: StoreOf<TestFeature>
    
    var body: some View {
        //WithPerceptionTracking {
            Button {
                send(.userTapedTestButton)
            } label: {
                Text("Button test")
            }
        //} -> to używamy tylko do iOS 17.0
    }
}
