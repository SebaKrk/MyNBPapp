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
                Text("PickerTCA")
                Spacer().frame(height: 50)
                picker
                Spacer()
                fetchButton
            }
        }
        .onAppear {
            send(.vieDidAppear)
        }
    }
    
    @ViewBuilder
    private var picker: some View {
        if store.periods != nil {
            Picker("Picker", selection: $store.selectedPeriod.sending(\.selectedPeriodChange)) {
                if let periods = store.periods {
                    Text(periods.current.dateFrom)
                        .tag(periods.current)
                    
                    Text(periods.previous.dateFrom)
                        .tag(periods.previous)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 200)
        } else {
            ProgressView()
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
