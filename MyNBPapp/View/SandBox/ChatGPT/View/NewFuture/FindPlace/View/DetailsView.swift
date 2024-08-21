//
//  DetailsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/08/2024.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var detailsItem: MKMapItem?
    
    var body: some View {
        VStack {
            headerTitle
            Spacer()
            if let item = detailsItem {
                itemTitle(item)
            }
            Spacer()
        }
    }
    
    private var headerTitle: some View {
        HStack {
            Spacer()
            cancelButton
        }
        .padding()
    }
    
    private func itemTitle(_ item: MKMapItem) -> some View {
        Text(item.name ?? "")
    }
    
    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
        }
    }
    //Text(item.name ?? "Brak nazwy") //.name ?? "")
}
