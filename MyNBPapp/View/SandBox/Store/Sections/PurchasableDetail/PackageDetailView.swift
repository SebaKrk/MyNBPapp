//
//  PackageDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 06/10/2024.
//

import SwiftUI

struct PackageDetailView:View {
    
    let package: PackagePresenter
    
    init(_ package: PackagePresenter) {
        self.package = package
    }
    
    var body: some View {
        VStack {
            Text(package.name)
                .bold()
            ForEach(package.products) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.price) pln")
                }
            }
            Text("Cena: \(package.getPrice()) pln")
        }
    }
        
}
