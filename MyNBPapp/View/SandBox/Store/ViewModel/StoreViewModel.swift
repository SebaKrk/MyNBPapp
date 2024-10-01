//
//  StoreViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/09/2024.
//

import SwiftUI

final class StoreViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var products: [ProductPresenter] = []
    @Published var packages: [PackagePresenter] = []
    @Published var items: [PurchasableItem] = []
    
    @Published var showProductCardDetails: Bool = false
    @Published var selectedProduct: PurchasableItem?
    
    private let service: AppleProductsService
    
    // MARK: - Lifecycle
    
    init(service: AppleProductsService = .shared) {
        self.service = service
    }
    
    // MARK: - Methods
    
    @MainActor
    func fetchStoreData() async {
        do {
            let storeData = try await service.fetchStoreData(from: jsonAppleProductsWithPackages)
            
            products = storeData.products.map { ProductPresenter(product: $0) }
            packages = storeData.packages.map { PackagePresenter(package: $0) }
        } catch {
            print("Błąd pobierania danych: \(error.localizedDescription)")
        }
    }
    
    func selectProduct(_ product: PurchasableItem) {
        selectedProduct = product
        showProductCardDetails.toggle()
    }
}
