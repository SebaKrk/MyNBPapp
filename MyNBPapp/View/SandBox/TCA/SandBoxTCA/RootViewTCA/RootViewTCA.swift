//
//  RootViewTCA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import ComposableArchitecture
import SwiftUI

struct RootViewTCA: View {
    
    @Bindable var store: StoreOf<RootFeatureTCA>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                SandBoxViewC(store: store.scope(state: \.sandBoxCFeature, action: \.sandBoxCFeature))
                    .frame(height: 100)
                
                sectionOne
                    
                sectionTwo
                
                sectionThree
                
                sectionFour
            }
            .navigationTitle("Root")
            .toolbar { starRootButton }
        } destination: { store in
            switch store.case {
            case let .sandBoxA(store):
                SandBoxViewA(store: store)
            case let .sandBoxB(store):
                SandBoxBView(store: store)
//            case let .sandBoxC(store):
//                SandBoxViewC(store: store)
            }
        }
        .sheet(item: $store.scope(state: \.destination?.openNewScreen,
                                  action:  \.destination.openNewScreen)) { store in
            SandBoxStarView(store: store)
        }
    }
    
    @ViewBuilder
    var sectionOne: some View {
        Section {
            NavigationLink(state: RootFeatureTCA.Path.State.sandBoxA(SandBoxA.State())) {
                Image(systemName: "arrow.right")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionTwo: some View {
        Section {
            Button {
                store.send(.goToViewAAA)
            } label: {
                Text("Go to A → A → A")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionThree: some View {
        Section {
            Button {
//                store.send(.sandBoxCFeature(SandBoxC.Action))
            } label: {
                Text("pop to root")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sectionFour: some View {
        Section {
            NavigationLink(state: RootFeatureTCA.Path.State.sandBoxB(SandBoxB.State())) {
                Text("Go to → B")
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var starRootButton: some View {
        Button {
            store.send(.starButtonTapped)
        } label: {
            Image(systemName: "star")
        }
    }
}
