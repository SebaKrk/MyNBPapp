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
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .main:
            MainView()
        case .rate:
            CurrencyRateView()
        case .favorites:
            //FavoritesView()
            TestView(store: Store(initialState: TestFeature.State(),
                                  reducer: { TestFeature() }))
        case .account:
            //            AccountView(store: Store(initialState: AccountFeature.State(),
            //                                     reducer: { AccountFeature() }))
            
            ContactsView(store: Store(initialState: ContactsFeature.State(),
                                      reducer: { ContactsFeature() }))
        }
    }
    
}
