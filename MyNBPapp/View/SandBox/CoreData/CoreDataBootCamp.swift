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
}

struct CoreDataBootCamp: View {
    
    @StateObject var viewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Add fruit here ...", text: $textFieldText)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button {
                guard !textFieldText.isEmpty else { return }
                viewModel.addFruit(text: textFieldText)
                textFieldText = ""
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            
            List {
                ForEach(viewModel.saveEntities) { item in
                    Text(item.name ?? "NO NAME")
                }
                .onDelete(perform: viewModel.deletedFruit)
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
    }
    
}
