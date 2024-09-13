//
//  FiltersPlaceView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 20/08/2024.
//

import SwiftUI
import MapKit

struct FiltersPlaceView: View {
    
    @Binding var category: [MKPointOfInterestCategory]
    @Binding var selectedCategory: MKPointOfInterestCategory?
    @Binding var showFilters: Bool

    @Environment(\.dismiss) var dismiss
    
    init(category: Binding<[MKPointOfInterestCategory]>,
         selectedCategory: Binding<MKPointOfInterestCategory?>,
         showFilters: Binding<Bool>) {
        self._category = category
        self._selectedCategory = selectedCategory
        self._showFilters = showFilters
    }
    
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
        Text("Filtry").bold()
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
            showFilters = false
        } label: {
            Text("Zastosuj")
        }
    }
    
    private var filtersContainer: some View {
        GroupBox {
            AnyLayout(FlowLayout(spacing: 6)) {
                ForEach(category, id: \.self) { item in
                    categoryButton(item)
                }
            }
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding([.leading, .trailing])
    }
    
    private func categoryButton(_ item: MKPointOfInterestCategory) -> some View {
        Button {
            selectedCategory = item
        } label: {
            categoryLabel(item)
        }
    }
    
    private func categoryLabel(_ item: MKPointOfInterestCategory) -> some View {
        Text(item.displayName())
            .foregroundStyle(item == selectedCategory ? Color.blue : Color.black)
            .font(.body)
            .padding(4)
            .background {
                Capsule()
                    .fill(item == selectedCategory ? Color.blue.opacity(0.1) : Color.clear)
                    .stroke(item == selectedCategory ? Color.blue : Color.primary, lineWidth: 1)
            }
    }
}



#Preview {
    @Previewable @State var mockCategory: [MKPointOfInterestCategory] = [.museum, .restaurant, .cafe]
    @Previewable @State var category: MKPointOfInterestCategory? = .airport
    @Previewable @State var showFilters: Bool = false
    
    FiltersPlaceView(category: $mockCategory, selectedCategory: $category, showFilters: $showFilters)
}
