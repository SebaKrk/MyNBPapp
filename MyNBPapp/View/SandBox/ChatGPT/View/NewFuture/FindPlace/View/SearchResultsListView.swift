//
//  SearchResultsListView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/08/2024.
//

import SwiftUI
import MapKit

struct SearchResultsListView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    @Binding var items: [MKMapItem]
    
    @State var singleSelection: MKMapItem?
    @State var showDetails: Bool = false
    @State var showFilters: Bool = false
    
    @State var title: String
    @State var numberOfItem: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            headerView
            Divider()
            Spacer()
            list
                /// dostepne w iOS 18.0 prezentuje podglad miejsca
                //.mapItemDetailSheet(item: $singleSelection)
                .sheet(isPresented: $showDetails) {
                    DetailsView(detailsItem: $singleSelection)
                        .presentationDetents([.height(300), .medium, .large])
                }
                .sheet(isPresented: $showFilters) {
                    FiltersPlaceView()
                        .presentationDetents([.height(200)])
                }
        }
    }
    
    // MARK: - SubView
        
    private var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                imageView
                VStack(alignment: .leading) {
                    headerTitle(title)
                    HStack {
                        numberOfItemSearch(numberOfItem)
                        editButton
                        Spacer()
                    }
                }
                Spacer()
                cancelButton
            }
            HStack {
                buttonTypes
                buttonSortMenu
                Spacer()
            }
        }
        .frame(height: 80)
        .padding()
    }
    
    private var list: some View {
        List {
            ForEach(items, id: \.self) { item in
                Button {
                    singleSelection = item
                    showDetails = true
                } label: {
                    listCell(item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }
    
    /// rozkminić jak przekazać z api ikonę oraz kolor tła
    private var imageView: some View {
        Image(systemName: "building.columns.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(red: 0.95,
                                   green: 0.45,
                                   blue: 0.76))
            .frame(width: 30, height: 30)
    }
    
    private func headerTitle(_ title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
    }
    
    private func numberOfItemSearch(_ numer: Int) -> some View {
        Text("\(numer) znaleziono")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    private var editButton: some View {
        EditButton()
            .font(.subheadline)
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
    
    /// to cos będzie musiało przyjąć z api żeby sprawdzić jakie są rodzaje
    private var buttonTypes: some View {
        Button {
            showFilters.toggle()
        } label: {
            Group {
                HStack {
                    Text("Wszystkie rodzaje")
                    Image(systemName: "chevron.down")
                }
            }
            .foregroundColor(Color.primary)
            .padding(4)
            .padding([.leading, .trailing], 6)
        }
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    private var buttonSortMenu: some View {
        Menu {
            Text("przykład")
        } label: {
            Group {
                HStack {
                    Text("Sortuj")
                    Image(systemName: "chevron.down")
                }
            }
            .foregroundColor(.primary)
            .padding(4)
            .padding([.leading, .trailing], 6)
        }
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    private func listCell(_ item: MKMapItem) -> some View {
        VStack(alignment: .leading) {
            Text(item.name ?? "Unknown Place")
                .font(.body)
                .foregroundStyle(.primary)
            HStack {
                /// dystans
                Text("200 m")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                /// kategoria
                /// MKPointOfInterestCategory
                if let category = item.pointOfInterestCategory {
                    Text(categoryName(for: category))
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                /// info zamkniete otwarte
                Text("zamkniete")
                    .font(.subheadline)
                    .foregroundStyle(.red)
                /// godziny otwarcia
                
                Text("10:00-20:00")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            /// adres
            Text(item.placemark.title ?? "No Address Available")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            //            let street = item.placemark.thoroughfare ?? ""
            //            let city = item.placemark.locality ?? ""
            //            let fullAddress = "\(street), \(city)"
        }
    }
    
    //    if let phone = item.phoneNumber {
    //        Text("\(phone)")
    //    }

    //            if let userLocation = mapView.userLocation.location {
    //                let distance = item.placemark.location?.distance(from: userLocation)
    //                let distanceString = String(format: "%.2f km", (distance ?? 0) / 1000)
    //            }
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func categoryName(for category: MKPointOfInterestCategory) -> String {
        switch category {
        case .museum:
            return "Muzeum"
        case .aquarium:
            return "Akwarium"
        case .amusementPark:
            return "Park rozrywki"
        case .zoo:
            return "Zoo"
        case .library:
            return "Biblioteka"
        default:
            return "Inne"
        }
    }
}

#Preview {
    @Previewable @State var mockItems: [MKMapItem] = {
        var items = [MKMapItem]()
        let item1 = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)))
        item1.name = "San Francisco"
        items.append(item1)
        
        let item2 = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)))
        item2.name = "Los Angeles"
        items.append(item2)
        
        return items
    }()
    
    SearchResultsListView(items: $mockItems,
                          title: "Muzea",
                          numberOfItem: 2)
}


//            HStack {
//                Spacer()
//                EditButton()
//            }
//            Spacer()
//            List {
//                ForEach(items, id: \.self) { item in
//                    Button {
//                        singleSelection = item
//                        dump("seba \(item)")
//                        showDetails = true
//                    } label: {
//                        cell(item.name ?? "brak")
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .listStyle(.plain)
//            .sheet(isPresented: $showDetails) {
//                DetailsView(detailsItem: $singleSelection)
//            }


//        HStack {
//            HStack {
//                Image(systemName: "building.columns.circle.fill")
//                    .foregroundStyle(.pink)
//                    .scaledToFit()
//                    .frame(width: 50)
//                HStack {
//                    headerTitle(title)
//                    Spacer()
//                    VStack {
//                        numberOfItemSearch(numberOfItem)
//                        editButton
//                        Spacer()
//                    }
//                }
//            }
//            VStack {
//                buttonTypes
//                buttonSortMenu
//                Spacer()
//            }
//            Spacer()
//        }
