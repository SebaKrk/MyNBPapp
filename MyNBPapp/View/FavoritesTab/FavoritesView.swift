//
//  FavoritesView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI
import Observation

struct FavoritesView2: View {
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Text("FavoritesView")
                    Text("FavoritesView")
                    Text("FavoritesView")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.yellow)
        }
    }
    
}

import SwiftData

@Model
class Favorite {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct FavoritesView: View {
 
    @Environment(\.modelContext) var context
    @Query var favorites: [Favorite]
    
    @State var name: String = ""
    var body: some View {

        VStack {
            HStack {
                TextField("Enter favorite name ", text: $name)
                Button {
                    let favorite = Favorite(name: name)
                    context.insert(favorite)
                    try! context.save()
                } label: {
                    Text("Save")
                }
            }
            Section {
                List {
                    ForEach(favorites) { item in
                        Text(item.name)
                    }
                }
            } header: {
                Text("Favorite")
            }

        }
      
    }
}
