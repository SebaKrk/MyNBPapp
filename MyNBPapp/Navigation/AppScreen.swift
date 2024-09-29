//
//  AppScreen.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 21/01/2024.
//

import ComposableArchitecture
import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    
    case main
    case rate
    case favorites
    case account
    case sandBox
    case coreData
    case chatGPT
    case payment
    case map
    case contact
    case store
    
    var id: AppScreen { self }
    
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .main:
            Label(String(localized: "Main", comment: "The Main Tab presents the primary view of the application."),
                  systemImage: "chart.bar.doc.horizontal")
        case .rate:
            Label(String(localized: "Rates", comment: "The Exchange Rate Tab displays selected currency exchange rate charts."),
                  systemImage: "chart.line.uptrend.xyaxis")
        case .favorites:
            Label(String(localized: "Favorites", comment: "The Favorites Tab - rates that have been added to favorites"),
                  systemImage: "star")
        case .account:
            Label(String(localized: "Account", comment: "The Account tab provides a personalized space where users can manage their profile and settings."),
                  systemImage: "person")
        case .sandBox:
            Label(String(localized: "Sandbox", comment: "The ‘Sandbox’ tab in the application is my testing area where I experiment with various features and solutions using TCA."),
                  systemImage: "shippingbox")
        case .coreData:
            Label(String(localized: "CoreData", comment: "The `CoreData` tab in the application is my testing area for CoreData "), systemImage: "archivebox.fill")
            
        case .chatGPT:
            Label(String(localized: "ChatGPT", comment: "The ‘chatGPT’ tab in the application is my testing area and experiment with chat gpt technology"), systemImage: "message")
        case .payment:
            Label(String(localized: "Payment", comment: "Payment Abstract Factory implementation"), systemImage: "creditcard")
        case .map:
            Label(String(localized: "Map", comment: "map"), systemImage: "map")
        case .contact:
            Label(String(localized: "Contact", comment: "contact"), systemImage: "person")
        case .store:
            Label(String(localized: "Store", comment: "store"), systemImage: "bag")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .main:
            MainView()
        case .rate:
            // CurrencyRateView()
            // RootView(store: Store(initialState: RootFeature.State(),
            //                 reducer: { RootFeature() }))
            
            RootViewTCA(store: Store(initialState: RootFeatureTCA.State(),
                                     reducer: { RootFeatureTCA() }))
        case .favorites:
            FavoritesView()
        case .account:
            AccountView(store: Store(initialState: AccountFeature.State(),
                                     reducer: { AccountFeature() }))
        case .sandBox:
            RootView(store: Store(initialState: RootFeature.State(),
                                  reducer: { RootFeature() }))
        case .coreData:
            CoreDataBootCamp()
            
        case .chatGPT:
            let viewModel = ChatViewModel()
            ChatView(viewModel: viewModel)
        case .payment:
            Payment()
        case .map:
            SandBoxMapView()
        case .contact:
            ContactsView(store: Store(initialState: ContactsFeature.State(),
                                      reducer: { ContactsFeature() }))
        case .store:
            StoreView()
        }
    }
    
}

//SandBoxMapView()
//MapView()
//            ContactsView(store: Store(initialState: ContactsFeature.State(),
//                                      reducer: { ContactsFeature() }))
//TestView(store: Store(initialState: TestFeature.State(),
//                      reducer: { TestFeature() }))

