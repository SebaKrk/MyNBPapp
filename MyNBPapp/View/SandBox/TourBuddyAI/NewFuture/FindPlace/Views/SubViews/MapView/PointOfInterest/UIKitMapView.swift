//
//  UIKitMapView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

struct UIKitMapView: MapViewFactory, View {
    
    @ObservedObject var viewModel: UIKitMapViewModel
    
    
    init(viewModel: UIKitMapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            createMap()
            HStack {
                createCategoryButtonPOI()
                Spacer()
            }
        }
    }
    
    func createMap() -> some View {
        MapViewRepresentable(viewModel: viewModel)
    }
    
    func createCategoryButtonPOI() -> some View {
        VStack {
            ScrollView(.horizontal) {
                VStack {
                    ForEach(viewModel.pointOfInterestCategories, id: \.rawValue) { category in
                        createButtonPOI(category)
                    }
                }
                .padding(.leading)
                .frame(width: 50)
            }
        }
        .padding(.bottom,30)
    }
    
    private func createButtonPOI(_ poi: MKPointOfInterestCategory) -> some View {
        ButtonPOI(category: poi) {
            print(poi.displayName())
        }
    }
    
}

struct ButtonPOI: View {
    
    var category: MKPointOfInterestCategory
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            IconViewPOI(category: category)
        }
    }
}

struct IconViewPOI: View {
    var category: MKPointOfInterestCategory
    
    var body: some View {
        Image(systemName: category.imagePOI())
            .fixedSize()
            .foregroundStyle(Color.primary)
            .padding(2)
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .stroke(Color.primary, lineWidth: 1)
                    .fill(category.backgroundPOI().opacity(0.5))
            )
    }
    
}
