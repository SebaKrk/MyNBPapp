//
//  FiltersPlaceView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/08/2024.
//

import SwiftUI

struct FiltersPlaceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            headerNavigation
            filtersContainer
            Spacer()
        }
    }
    
    private var headerNavigation: some View {
        HStack {
            cancelButton
            Spacer()
            navigationTitle
            Spacer()
            applyButton
        }
        .padding()
        
    }
    
    private var navigationTitle: some View {
        Text("Filtry")
            .bold()
    }
    
    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Anuluj")
        }
    }
    
    private var applyButton: some View {
        Button {
            print("Zastosuj")
        } label: {
            Text("Zastosuj")
        }
    }
    
    private var filtersContainer: some View {
        GroupBox {
            Text("filtersContainer")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding([.leading, .trailing])
    }

    
}

#Preview {
    FiltersPlaceView()
}
