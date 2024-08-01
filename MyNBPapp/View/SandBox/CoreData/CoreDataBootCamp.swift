//
//  CoreDataBootCamp.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 05/06/2024.
//

import CoreData
import SwiftUI

final class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var saveEntities: [FruitEntity] = []
    @Published var saveFav: [FavoritesEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
        fetchFruit()
        fetchFav()
    }
    
    func fetchFruit() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            saveEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetch core data \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruit()
        } catch let error {
            print("error saving data \(error)")
        }
    }
    
    func deletedFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = saveEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruits(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func addToFavorites(entity: FruitEntity) {
        
        let newFav = FavoritesEntity(context: container.viewContext)
        newFav.name = entity.name
        
        do {
            try container.viewContext.save()
            fetchFav()
        } catch let error {
            print("error saving data \(error)")
        }
    }
    
    func fetchFav() {
        let request = NSFetchRequest<FavoritesEntity>(entityName: "FavoritesEntity")
        do {
            saveFav = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetch core data \(error)")
        }
    }
}

struct CoreDataBootCamp: View {
    
    // MARK: - Properties
    
    @ObservedObject  var viewModel: CoreDataViewModel
    @State var textFieldText: String = ""
    
    // MARK: - Lifecycle
    
    init(viewModel: CoreDataViewModel = CoreDataViewModel()) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 20) {
            textField("Add fruit here ...", text: $textFieldText)
            saveButton("Save")
            
            List {
                ForEach(viewModel.saveEntities) { item in
                    Text(item.name ?? "NO NAME")
                        .onTapGesture {
                            viewModel.updateFruits(entity: item)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                            favoriteButton(item)
                        })
                }
                .onDelete(perform: viewModel.deletedFruit)
            }
            .listStyle(.plain)
            
            List {
                ForEach(viewModel.saveFav) { item in
                    Text(item.name ?? "No Fav")
                }
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - SubView
    
    @ViewBuilder
    func textField(_ title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .font(.headline)
            .padding(.leading)
            .frame(height: 55)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    func saveButton(_ label: String) -> some View {
        Button {
            guard !textFieldText.isEmpty else { return }
            viewModel.addFruit(text: textFieldText)
            textFieldText = ""
        } label: {
            Text(label)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    func favoriteButton(_ entity: FruitEntity) -> some View {
        Button {
            print(entity)
            viewModel.addToFavorites(entity: entity)
            dump(viewModel.saveFav)
        } label: {
            Image(systemName: "star")
        }
    }
    
}
