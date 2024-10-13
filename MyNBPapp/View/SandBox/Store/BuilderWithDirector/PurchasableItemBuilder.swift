////
////  PurchasableItemBuilder.swift
////  MyNBPapp
////
////  Created by Sebastian Sciuba on 12/10/2024.
////
//
//import Foundation
//
////struct Product: Codable, Identifiable {
////
////    let id: String
////    let name: String
////    let price: Int
////    let image: String
////
////}
//
//
//// Model produktu
//struct ProductStore: Codable, Identifiable {
//    let id: String
//    let name: String
//    let price: Int
//    let image: String
//    let stock: Int
//    let available: Bool
//}
//
//// Protokół dla buildera
//protocol ProductBuilderProtocol {
//    
//    func setId(_ id: String) -> Self
//    func setName(_ name: String) -> Self
//    func setPrice(_ price: Int) -> Self
//    func setImage(_ image: String) -> Self
//    func setStock(_ stock: Int) -> Self
//    func setAvailable(_ available: Bool) -> Self
//    
//    func build() -> ProductStore
//}
//
//// Implementacja buildera
//class ProductBuilder: ProductBuilderProtocol {
//    
//    private var id: String = ""
//    private var name: String = ""
//    private var price: Int = 0
//    private var image: String = ""
//    private var stock: Int = 0
//    private var available: Bool = false
//    
//    func setId(_ id: String) -> Self {
//        self.id = id
//        return self
//    }
//    
//    func setName(_ name: String) -> Self {
//        self.name = name
//        return self
//    }
//    
//    func setPrice(_ price: Int) -> Self {
//        self.price = price
//        return self
//    }
//    
//    func setImage(_ image: String) -> Self {
//        self.image = image
//        return self
//    }
//    
//    func setStock(_ stock: Int) -> Self {
//        self.stock = stock
//        return self
//    }
//    
//    func setAvailable(_ available: Bool) -> Self {
//        self.available = available
//        return self
//    }
//    
//    func build() -> ProductStore {
//        ProductStore(
//            id: id,
//            name: name,
//            price: price,
//            image: image,
//            stock: stock,
//            available: available
//        )
//    }
//}
//
//// Director
//class ProductViewDirector {
//    private let builder: ProductBuilderProtocol
//    
//    init(builder: ProductBuilderProtocol) {
//        self.builder = builder
//    }
//    
//    // Budowanie standardowego produktu
//    func constructStandardProduct(id: String, name: String, price: Int, image: String, stock: Int, available: Bool) -> ProductStore {
//        return builder
//            .setId(id)
//            .setName(name)
//            .setPrice(price)
//            .setImage(image)
//            .setStock(stock)
//            .setAvailable(available)
//            .build()
//    }
//    
//    // Budowanie produktu promocyjnego z dynamicznymi parametrami
//    func constructDiscountedProduct(id: String, name: String, price: Int, discountedPrice: Int, image: String, stock: Int, available: Bool) -> ProductStore {
//        return builder
//            .setId(id)
//            .setName(name)
//            .setPrice(discountedPrice)
//            .setImage(image)
//            .setStock(stock)
//            .setAvailable(available)
//            .build()
//    }
//    
//    // Budowanie produktu, który jest niedostępny - dynamicznie przekazujemy stock i dostępność
//    func constructUnavailableProduct(id: String, name: String, price: Int, image: String, stock: Int = 0, available: Bool = false) -> ProductStore {
//        return builder
//            .setId(id)
//            .setName(name)
//            .setPrice(price)
//            .setImage(image)
//            .setStock(stock) // Brak stanu magazynowego
//            .setAvailable(available) // Niedostępny produkt
//            .build()
//    }
//    
//    // Budowanie produktu z dużym zapasem magazynowym - dynamiczne parametry
//    func constructBulkStockProduct(id: String, name: String, price: Int, image: String, stock: Int = 100, available: Bool = true) -> ProductStore {
//        return builder
//            .setId(id)
//            .setName(name)
//            .setPrice(price)
//            .setImage(image)
//            .setStock(stock) // Duży zapas
//            .setAvailable(available)
//            .build()
//    }
//}
//
//struct RawProductData {
//    let id: String
//    let name: String
//    let price: Int
//    let discountedPrice: Int?
//    let image: String
//    let stock: Int
//    let available: Bool
//}
//
//// ViewModel
//class ProductViewModel: ObservableObject {
//    
//    @Published var products: [ProductStore] = []
//    
//    // Dane surowe produktów, które są przetwarzane
//    let rawProductData: [RawProductData] = [
//        RawProductData(id: "123", name: "Laptop 123", price: 1500, discountedPrice: nil, image: "laptop.png", stock: 10, available: true),
//        RawProductData(id: "124", name: "Laptop 124", price: 1500, discountedPrice: 1200, image: "laptop.png", stock: 0, available: false),
//        RawProductData(id: "125", name: "Laptop 125", price: 1500, discountedPrice: nil, image: "laptop.png", stock: 100, available: true)
//    ]
//    
//    func buildProducts() {
//        let builder = ProductBuilder()
//        let director = ProductViewDirector(builder: builder)
//        
//        // Przetwarzamy każdy produkt z danych surowych
//        products = rawProductData.map { rawData in
//            if rawData.stock == 0 {
//                // Produkt niedostępny
//                return director.constructUnavailableProduct(
//                    id: rawData.id,
//                    name: rawData.name,
//                    price: rawData.price,
//                    image: rawData.image
//                )
//            } else if let discountedPrice = rawData.discountedPrice {
//                // Produkt promocyjny
//                return director.constructDiscountedProduct(
//                    id: rawData.id,
//                    name: rawData.name,
//                    price: rawData.price,
//                    discountedPrice: discountedPrice,
//                    image: rawData.image,
//                    stock: rawData.stock,
//                    available: rawData.available
//                )
//            } else {
//                // Standardowy produkt
//                return director.constructStandardProduct(
//                    id: rawData.id,
//                    name: rawData.name,
//                    price: rawData.price,
//                    image: rawData.image,
//                    stock: rawData.stock,
//                    available: rawData.available
//                )
//            }
//        }
//    }
//}
//
//// Widok
//import SwiftUI
//struct ContentProductView: View {
//    
//    @StateObject private var viewModel = ProductViewModel()
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                ForEach(viewModel.products, id: \.id) { product in
//                    VStack {
//                        titleLabel(product.name)
//                        priceLabel(product.price)
//                        imageView(product.image)
//                        stockLabel(product.stock, available: product.available)
//                    }
//                    .padding()
//                    .border(Color.gray, width: 1)
//                }
//            }
//        }
//        .onAppear {
//            viewModel.buildProducts()
//        }
//    }
//    
//    func titleLabel(_ name: String) -> some View {
//        Text(name)
//            .font(.title)
//    }
//    
//    func priceLabel(_ price: Int) -> some View {
//        Text("Price: \(price)$")
//            .font(.subheadline)
//    }
//    
//    func imageView(_ name: String) -> some View {
//        Image(systemName: "photo")
//            .resizable()
//            .scaledToFit()
//            .frame(height: 200)
//    }
//    
//    func stockLabel(_ stock: Int, available: Bool) -> some View {
//        if available {
//            return Text("In stock: \(stock)")
//                .foregroundColor(.green)
//        } else {
//            return Text("Out of stock")
//                .foregroundColor(.red)
//        }
//    }
//}
