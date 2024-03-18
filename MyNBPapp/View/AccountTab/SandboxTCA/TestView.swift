//
//  TestView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 23/02/2024.
//

import ComposableArchitecture
import SwiftUI

var contactArray: [Contact] = [
    Contact(id: UUID(), name: "Sebastian"),
    Contact(id: UUID(), name: "Natalia"),
    Contact(id: UUID(), name: "Zuza")
]

@ViewAction(for: TestFeature.self)
struct TestView: View {
    
    @Bindable var store: StoreOf<TestFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List {
                ForEach(contactArray) { item in
                    NavigationLink(state: TestFeature2.State(contact: item)) {
                        Text(item.name)
                    }
                }
            }
        } destination: { scope in
            TestView2(store: scope)
        }
    }
}
