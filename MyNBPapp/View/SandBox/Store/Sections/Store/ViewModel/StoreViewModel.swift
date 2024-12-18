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
    
    @Published var showProductCardDetails: Bool = false
    @Published var showCartView: Bool = false
    @Published var triggerEffect: Bool = false
    @Published var selectedProduct: PurchasableItem?
    
    @Published var showPaymentCard: Bool = false
    @Published var paymnet: String?
    
    private let service: AppleProductsService
    
    // MARK: - Lifecycle
    
    init(service: AppleProductsService = .shared) {
        self.service = service
    }
    
    // MARK: - Methods
    
    @MainActor
    func fetchStoreData() async {
        do {
            let storeData = try await service.fetchStoreData(from: jsonAppleProductsWithUUID)
            
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
    
    func handleCartButtonTapped(_ cartViewModel: CartViewModel) {
         if cartViewModel.items.isEmpty {
             triggerEffect.toggle()
         } else {
             showCartView.toggle()
         }
     }
}
