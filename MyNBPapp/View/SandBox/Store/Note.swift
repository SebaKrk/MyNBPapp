//
//  Note.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 01/10/2024.
//
//
//import Foundation
//
//
//struct StoreView2: View {
//    
//    @StateObject private var viewModel = StoreViewModel()
//    @StateObject private var cart = Cart()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    Section(header: Text("Produkty")) {
//                        ForEach(viewModel.products, id: \.name) { product in
//                            HStack {
//                                Text(product.display())
//                                Spacer()
//                                Button(action: {
//                                    cart.addToCart(product)
//                                }) {
//                                    Text("Dodaj do koszyka")
//                                        .foregroundColor(.blue)
//                                }
//                            }
//                        }
//                    }
//                    
//                    Section(header: Text("Pakiety")) {
//                        ForEach(viewModel.packages, id: \.name) { package in
//                            HStack {
//                                Text(package.display())
//                                Spacer()
//                                Button(action: {
//                                    cart.addToCart(package)
//                                }) {
//                                    Text("Dodaj do koszyka")
//                                        .foregroundColor(.blue)
//                                }
//                            }
//                        }
//                    }
//                }
//                
//                Text("Suma w koszyku: \(cart.totalPrice())")
//                    .padding()
//                
//                Text("Produkty w koszyku:")
//                Text(cart.displayCartItems())
//                    .padding()
//            }
//            .navigationTitle("Sklep")
//        }
//        .task {
//            await viewModel.fetchStoreData()
//        }
//    }
//}
//
//final class Cart: ObservableObject {
//    @Published var items: [PurchasableItem] = []
//    
//    func addToCart(_ item: PurchasableItem) {
//        items.append(item)
//    }
//    
//    func totalPrice() -> Int {
//        return items.reduce(0) { $0 + $1.getPrice() }
//    }
//    
//    func displayCartItems() -> String {
//        return items.map { $0.display() }.joined(separator: "\n")
//    }
//}
