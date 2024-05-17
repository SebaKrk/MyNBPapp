//
//  ChooseConcurrency.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 30/04/2024.
//

import AppIntents
import SwiftUI

//struct ChooseConcurrency: AppIntent {
//
//    static var title: LocalizedStringResource = "ChooseConcurrency"
//
//    @Parameter(title: "Waluta")
//    var currency: Currency
//
//    @Parameter(title: "Date")
//    var date: Date
//}
//
//
//struct CurrencyResult: IntentResult {
//    var value: Never?
//
//    var successMessage: String
//    var currencyValue: Double
//}
//
//struct CurrencySummary: Hashable, CustomStringConvertible {
//    var description: String {
//        return "Wybrana waluta to \(currency), data: \(formattedDate)"
//    }
//
//    var currency: String
//    var formattedDate: String
//}

//struct SuperCharge: AppIntent {
//    
//    static var title: LocalizedStringResource = "Emoji Ranger SuperCharger"
//    static var description = IntentDescription("All heroes get instant 100% health.")
//    
//    func perform() async throws -> some IntentResult {
//        //EmojiRanger.superchargeHeros()
//        return .result()
//    }
//}
//
//struct EmojiRangerWidgetEntryView: View {
//    var entry: SimpleEntry
//    
//    @Environment(\.widgetFamily) var family
//    
//    @ViewBuilder
//    var body: some View {
//        switch family {
//            
//            
//        case .systemLarge:
//            VStack {
//                HStack(alignment: .top) {
//                    AvatarView(entry.hero)
//                        .foregroundColor(.white)
//                    Text(entry.hero.bio)
//                        .foregroundColor(.white)
//                }
//                .padding()
//                if #available(iOS 17.0, *) {
//                    HStack(alignment: .top) {
//                        Button(intent: SuperCharge()) {
//                            Image(systemName: "bolt.fill")
//                        }
//                    }
//                    .tint(.white)
//                    .padding()
//                }
//            }
//            .containerBackground(for: .widget) {
//                Color.gameBackgroundColor
//            }
//            .widgetURL(entry.hero.url)
//            
//            // Code for other widget sizes.
//        }
//    }
//    
//    
//    struct TodoItemView: View {
//        var todo: Todo
//        
//        
//        var body: some View {
//            Toggle(isOn: todo.complete, intent: ToggleTodoIntent(todo.id)) {
//                Text(todo.body)
//            }
//            .toggleStyle(TodoToggleStyle())
//        }
//    }
