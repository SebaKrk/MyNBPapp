//
//  FavoritesView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import SwiftUI
import Observation
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
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView {
                        Text("Jeszcze tu nic nie ma")
                    } description: {
                        Text("Nacisnij przycisk zeby cos doddac")
                    } actions: {
                        actionButton
                    }
                } else {
                    List {
                        ForEach(favorites) { item in
                            Text(item.name)
                        }
                        .onDelete(perform: deletedFruit)
                    }
                    .toolbar {
                        actionButton
                    }
                    .listStyle(.plain)
                    .navigationTitle("Account")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .sheet(isPresented: $isPresented) {
                textField
                    .presentationDetents([.medium])
            }
        }
    }
    
    func deletedFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = favorites[index]
        context.delete(entity)
        try? context.save()
    }
    
    private var actionButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var textField: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(.gray)
                TextField("Enter favorite name", text: $name)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            Button {
                let favorite = Favorite(name: name)
                context.insert(favorite)
                try! context.save()
                name = ""
                isPresented = false
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.top)
    }
}

// ########################################################### //

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
