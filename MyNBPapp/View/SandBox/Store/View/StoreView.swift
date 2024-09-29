//
//  StoreView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import SwiftUI

struct StoreView: View {
    
    private let service = AppleProductsService.shared
    
    @State var products: [Product] = []
    
    var body: some View {
        Text("Store View")
            .onAppear {
                Task {
                    do {
                        self.products = try await service.fetchProducts(from: jsonAppleProducts)
                        dump(products)
                    } catch {
                        print("Błąd podczas ładowania produktów: \(error)")
                    }
                }
            }
    }
}
