//
//  TestView2.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 19/03/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TestFeature2 {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    @CasePathable
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action { }
        }
        
    }
}

struct TestView2: View {
    
    var store: StoreOf<TestFeature2>
    
    var body: some View {
        Text(store.contact.name)
    }
    
}

