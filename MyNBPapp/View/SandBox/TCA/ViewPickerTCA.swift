//
//  ViewPickerTCA.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: PickerFeatureTCA.self)
struct ViewPickerTCA: View {
    
    @Bindable var store: StoreOf<PickerFeatureTCA>
        
    var body: some View {
        NavigationStack {
            VStack {
                fetchPeriodButton
                Text("PickerTCA")
                fetchButton
            }
        }
        .onAppear {
            send(.vieDidAppear)
        }
    }
    
    @ViewBuilder
    private var fetchPeriodButton: some View {
        Button  {
            send(.fetchPeriodButtonTapped)
        } label: {
            Text("Fetch period")
        }
    }
    
    @ViewBuilder
    private var fetchButton: some View {
        Button  {
            send(.fetchButtonTapped)
        } label: {
            Text("Fetch data")
        }
    }
}
