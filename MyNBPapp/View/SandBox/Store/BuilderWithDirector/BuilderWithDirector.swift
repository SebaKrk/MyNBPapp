//
//  BuilderWithDirector.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/10/2024.
//

import Foundation

//struct Product: Codable, Identifiable {
//
//    let id: String
//    let name: String
//    let price: Int
//    let image: String
//
//}

struct StockInfo: Codable {
    let productId: String
    let stock: Int
    let available: Bool
    let discountedPrice: Int?
}

struct ProductWithStock: Identifiable {
    let product: Product
    let stockInfo: StockInfo?

    var id: String {
        return product.id
    }
}

// Protokół dla buildera ProductWithStock
protocol ProductWithStockBuilderProtocol {
    func setProduct(_ product: Product) -> Self
    func setStockInfo(_ stockInfo: StockInfo?) -> Self
    func build() -> ProductWithStock
}

// Implementacja buildera z protokołem
class ProductWithStockBuilder: ProductWithStockBuilderProtocol {
    private var product: Product?  /// Obowiązkowy produkt
    private var stockInfo: StockInfo?  /// Opcjonalne dane magazynowe

    // Metoda do ustawienia produktu (obowiązkowe)
    func setProduct(_ product: Product) -> Self {
        self.product = product
        return self
    }

    // Metoda do ustawienia danych magazynowych (opcjonalne)
    func setStockInfo(_ stockInfo: StockInfo?) -> Self {
        self.stockInfo = stockInfo
        return self
    }

    // Metoda build - tworzy obiekt ProductWithStock
    func build() -> ProductWithStock {
        guard let product = product else {
            fatalError("Product data is required to build ProductWithStock")
        }
        return ProductWithStock(product: product, stockInfo: stockInfo)
    }
}

// Director zarządza procesem budowania
class ProductDirector {
    private let builder: ProductWithStockBuilderProtocol
    
    init(builder: ProductWithStockBuilderProtocol) {
        self.builder = builder
    }

    func constructBasicProduct(id: String, name: String, price: Int, image: String) -> ProductWithStock {
        
        let product = Product(id: id, name: name, price: price, image: image)
        
        return builder
            .setProduct(product)
            .build()  // Tworzymy produkt bez stockInfo (stockInfo = nil)
    }

    func constructProductWithStock(id: String, name: String, price: Int, image: String, stock: Int, available: Bool, discountedPrice: Int?) -> ProductWithStock {
        
        let product = Product(id: id, name: name, price: price, image: image)
        let stockInfo = StockInfo(productId: id, stock: stock, available: available, discountedPrice: discountedPrice)
        
        return builder
            .setProduct(product)
            .setStockInfo(stockInfo)  // Ustawiamy stockInfo
            .build()
    }
    
    func constructProductWithoutDiscount(id: String, name: String, price: Int, image: String, stock: Int, available: Bool) -> ProductWithStock {
        
        let product = Product(id: id, name: name, price: price, image: image)
        let stockInfo = StockInfo(productId: id, stock: stock, available: available, discountedPrice: nil)
        
        return builder
            .setProduct(product)
            .setStockInfo(stockInfo)
            .build()
    }
}


class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var stockData: [StockInfo] = []
    @Published var productsWithStock: [ProductWithStock] = []
    
    private let service: AppleProductsService
    private let builder: ProductWithStockBuilder
    private let director: ProductDirector

    init(service: AppleProductsService = .shared) {
        self.service = service
        self.builder = ProductWithStockBuilder()
        self.director = ProductDirector(builder: builder)
    }
    
    @MainActor
    func fetchStoreData() async {
        do {
            let data = try await service.fetchStoreData(from: jsonAppleProductsWithUUID)
            products = data.products
            
            stockData = [
                StockInfo(productId: "2f95b9d8-4f65-4c12-808b-b02835b4cfb9",
                          stock: 20, available: true, discountedPrice: 4799),
                StockInfo(productId: "bc8a112f-23e2-4d8d-844a-c7c9ad2f2b4c",
                          stock: 100, available: true, discountedPrice: nil),
                StockInfo(productId: "fbd9cba2-5e02-4a1e-a87b-9377cb17951d",
                          stock: 50, available: true, discountedPrice: 90)
            ]

            productsWithStock = products.map { product in
                let stockInfo = stockData.first { $0.productId == product.id }
                return ProductWithStock(product: product, stockInfo: stockInfo)
            }
        } catch {
            print("Error fetching store data: \(error)")
        }
        
        func x() {
            let builder = ProductWithStockBuilder()
            let director = ProductDirector(builder: builder)

            let productWithDiscount = director.constructProductWithStock(
                id: "123",
                name: "iPhone",
                price: 4999,
                image: "iphone.png",
                stock: 10,
                available: true,
                discountedPrice: 4499
            )
        }
    }
}

// Widok
import SwiftUI
struct ContentProductView: View {
    
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.productsWithStock, id: \.id) { productWithStock in
                    ProductRowView(productWithStock: productWithStock)
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchStoreData()
        }
    }

}


struct ProductRowView: View {
    
    let productWithStock: ProductWithStock
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(productWithStock.product.name)
                .font(.headline)
            
            Text("Price: \(productWithStock.product.price) PLN")
                .font(.subheadline)
            
            AsyncImage(url: URL(string: productWithStock.product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
            } placeholder: {
                ProgressView()
            }
            
            if let stockInfo = productWithStock.stockInfo {
                Text("In stock: \(stockInfo.stock)")
                    .foregroundColor(stockInfo.available ? .green : .red)
                
                if let discountedPrice = stockInfo.discountedPrice {
                    Text("Discounted Price: \(discountedPrice) PLN")
                        .foregroundColor(.orange)
                }
            } else {
                Text("No stock information available")
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}



//@MainActor
//func fetchStoreData2() async {
//    do {
//        let data = try await service.fetchStoreData(from: jsonAppleProductsWithUUID)
//        products = data.products
//        stockData = [
//            StockInfo(productId: "2f95b9d8-4f65-4c12-808b-b02835b4cfb9",
//                      stock: 20, available: true, discountedPrice: 4799),
//            StockInfo(productId: "bc8a112f-23e2-4d8d-844a-c7c9ad2f2b4c",
//                      stock: 100, available: true, discountedPrice: nil),
//            StockInfo(productId: "fbd9cba2-5e02-4a1e-a87b-9377cb17951d",
//                      stock: 50, available: true, discountedPrice: 90)
//        ]
//        
//        productsWithStock = products.map { product -> ProductWithStock in
//            let stockInfo = stockData.first(where: { $0.productId == product.id })
//            
//            switch stockInfo {
//            case .some(let info) where info.discountedPrice != nil:
//                // Tworzymy produkt z ceną promocyjną
//                return director.constructProductWithStock(
//                    id: product.id,
//                    name: product.name,
//                    price: product.price,
//                    image: product.image,
//                    stock: info.stock,
//                    available: info.available,
//                    discountedPrice: info.discountedPrice
//                )
//                
//            case .some(let info):
//                // Tworzymy produkt bez ceny promocyjnej
//                return director.constructProductWithoutDiscount(
//                    id: product.id,
//                    name: product.name,
//                    price: product.price,
//                    image: product.image,
//                    stock: info.stock,
//                    available: info.available
//                )
//                
//            case .none:
//                // Tworzymy **pojedynczy produkt** bez danych magazynowych
//                return director.constructBasicProduct(
//                    id: product.id,
//                    name: product.name,
//                    price: product.price,
//                    image: product.image
//                )
//            }
//        }
//        
//        dump(productsWithStock)
//    } catch {
//        print("Błąd pobierania danych: \(error.localizedDescription)")
//    }
//}
//
//
//func titleLabel(_ name: String) -> some View {
//    Text(name)
//        .font(.title)
//}
//
//func priceLabel(_ price: Int) -> some View {
//    Text("Price: \(price)$")
//        .font(.subheadline)
//}
//
//func imageView(_ name: String) -> some View {
//    Image(systemName: "photo")
//        .resizable()
//        .scaledToFit()
//        .frame(height: 200)
//}
//
//func stockLabel(_ stock: Int, available: Bool) -> some View {
//    if available {
//        return Text("In stock: \(stock)")
//            .foregroundColor(.green)
//    } else {
//        return Text("Out of stock")
//            .foregroundColor(.red)
//    }
//}
