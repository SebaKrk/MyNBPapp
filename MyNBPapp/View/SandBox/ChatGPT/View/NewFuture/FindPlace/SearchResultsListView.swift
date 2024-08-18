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
    @State var title: String
    @State var numberOfItem: Int

    // MARK: - Body
    
    var body: some View {
        VStack {
            headerView
            Divider()
            Spacer()
            list
                .sheet(isPresented: $showDetails) {
                    DetailsView(detailsItem: $singleSelection)
                        .presentationDetents([.height(150), .medium, .large])
                }
        }
    }
    
    // MARK: - SubView
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    imageView
                }
                VStack {
                    HStack {
                        headerTitle(title)
                        Spacer()
                    }
                    HStack {
                        numberOfItemSearch(numberOfItem)
                        editButton
                        Spacer()
                    }
                }
                Spacer()
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
                    cell(item.name ?? "brak")
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
    
    /// to cos będzie musiało przyjąć z api żeby sprawdzić jakie są rodzaje
    private var buttonTypes: some View {
        Button {
            
        } label: {
            Group {
                HStack {
                    Text("Wszystkie rodzaje")
                    Image(systemName: "chevron.down")
                }
            }
            .foregroundStyle(.black)
            .padding(4)
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
                .foregroundStyle(.black)
            }
            .padding(4)
        }
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    
    private func cell(_ item: String) -> some View {
        Text(item)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
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

struct DetailsView: View {
    
    @Binding var detailsItem: MKMapItem?
    
    var body: some View {
        if let item = detailsItem {
            Text(item.name ?? "Brak nazwy") //.name ?? "")
        }
    }
    
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
