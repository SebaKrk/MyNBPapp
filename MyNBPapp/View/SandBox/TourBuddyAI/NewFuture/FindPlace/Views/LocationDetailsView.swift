//
//  LocationDetailsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/08/2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    @Binding var mapSelection: MapSelection<MKMapItem>? //MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if let selection = mapSelection {
                        Text(selection.value?.placemark.name ?? "")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(selection.value?.placemark.title ?? "")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .lineLimit(2)
                            .padding(.trailing)
                    }
                }
                Spacer()
                Button {
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
                    .frame(height: 200)
            }
            Spacer()
        }
        .onAppear {
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            fetchLookAroundPreview()
        }
        .padding()
    }
    
    private func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                if let selectionItem = mapSelection.value {
                    let request = MKLookAroundSceneRequest(mapItem: selectionItem)
                    lookAroundScene = try? await request.scene
                }
            }
        }
    }
    
}
