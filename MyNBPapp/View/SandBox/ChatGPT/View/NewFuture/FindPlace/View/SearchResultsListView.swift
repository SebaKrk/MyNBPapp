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
    
    @State var mapItemWithRoute: [MapItemWithRoute] = []
    
    
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
            ForEach(mapItemWithRoute, id: \.mapItem) { item in
                Button {
                    singleSelection = item.mapItem
                    showDetails = true
                } label: {
                    listCell(item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                let krakowCenter = CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9366)
                await mapItemWithRoute = getDirectionsWithRoutes(from: krakowCenter, items: items)
            }
        }
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
    
    private func listCell(_ item: MapItemWithRoute) -> some View {
        HStack {
            VStack(alignment: .leading) {
                name(item.mapItem)
                HStack {
                    travelTime(item.route)
                    if let category = item.mapItem.pointOfInterestCategory {
                        categoryTitle(category)
                    }
                    if let city = item.mapItem.placemark.locality {
                        cityName(city)
                    }
                }
                openingHours()
                address(item.mapItem)
                Spacer()
            }
            Spacer()
            VStack {
                placeImage()
                Spacer()
            }
        }
    }
    
    /// nazwa
    private func name(_ mapItem: MKMapItem) -> some View {
        Text(mapItem.name ?? "Unknown Place")
            .bold()
            .font(.body)
            .foregroundStyle(.primary)
    }
    
    /// obraz miejsca / zdjęcie
    private func placeImage() -> some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 60)
            .clipped()
            .foregroundStyle(.secondary)
    }
    
    
    /// dystans
    private func travelTime(_ route: MKRoute?) -> some View {
        Text(getTravelTime(route) ?? "brak")
            .foregroundStyle(.secondary)
            .font(.subheadline)
    }
    
    /// kategoria -  MKPointOfInterestCategory
    private func categoryTitle(_ category: MKPointOfInterestCategory) -> some View {
        Text(categoryName(for: category))
            .foregroundStyle(.secondary)
    }
    
    /// miasto
    private func cityName(_ city: String) -> some View {
        Text(city)
            .foregroundStyle(.secondary)
    }
    
    /// godziny otwarcia
    private func openingHours() -> some View {
        // TODO: inne api do zaimplemetowania
        HStack {
            /// info
            Text("zamkniete")
                .font(.subheadline)
                .foregroundStyle(.red)
            
            /// godziny otwarcia
            Text("10:00-20:00")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    /// adres
    private func address(_ mapItem: MKMapItem) -> some View {
        var street = mapItem.placemark.thoroughfare ?? "No Address Available"
        var number = mapItem.placemark.subThoroughfare ?? ""
        
        return Group {
            Text("\(street) \(number)")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    
    /// dostępne kategorie
    private func categoryName(for category: MKPointOfInterestCategory) -> String {
        switch category {
        case .museum:
            return "Muzeum"
        case .castle:
            return "Zamek"
        case .fortress:
            return "Forteca"
        case .landmark:
            return "Miejsce historyczne"
        case .library:
            return "Biblioteka"
        case .nationalMonument:
            return "Pomnik"
        default:
            return "Inne"
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func getDirectionsWithRoutes(from userLocation: CLLocationCoordinate2D, items: [MKMapItem]) async -> [MapItemWithRoute] {
        var results: [MapItemWithRoute] = []

        for item in items {
            if let route = await getRoute(from: userLocation, to: item) {
                results.append(MapItemWithRoute(mapItem: item, route: route))
            } else {
                results.append(MapItemWithRoute(mapItem: item, route: nil))
            }
        }

        return results
    }

    private func getRoute(from userLocation: CLLocationCoordinate2D, to item: MKMapItem) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = item
        request.transportType = .walking

        let directions = MKDirections(request: request)
        do {
            let response = try await directions.calculate()
            return response.routes.first
        } catch {
            print("Error calculating directions: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getTravelTime(_ route: MKRoute?) -> String? {
        guard let route = route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
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


