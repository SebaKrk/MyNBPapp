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
//            dismiss()
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

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    // Layout function to calculate size and offsets
    func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> (size: CGSize, offsets: [CGPoint]) {
        var offsets: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxHeightInRow: CGFloat = 0
        
        for size in sizes {
            if currentX + size.width > containerWidth {
                // Move to the next line
                currentX = 0
                currentY += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            
            offsets.append(CGPoint(x: currentX, y: currentY))
            currentX += size.width + spacing
            maxHeightInRow = max(maxHeightInRow, size.height)
        }
        
        let totalHeight = currentY + maxHeightInRow
        return (CGSize(width: containerWidth, height: totalHeight), offsets)
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.width ?? .infinity
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
}
