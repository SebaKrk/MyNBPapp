//
//  ScreenAlert.swift
//  Rybka
//
//  Created by Sebastian Sciuba on 02/12/2024.
//
//
//import ComposableArchitecture
//import SwiftUI
//
//@Reducer
//struct ScreenAlert {
//    
//    // MARK: - State
//    @ObservableState
//    struct State: Equatable {
//        
//        var alertMessage: String = ""
//        
//        @Presents var alert: AlertState<Action.Alert>?
//    }
//    
//    // MARK: - Action
//    @CasePathable
//    enum Action: ViewAction {
//        
//        case presentAlert
//        
//        case view(View)
//        
//        public enum View: Equatable {
//            case presentAlertTapped
//        }
//        
//        case alert(PresentationAction<Alert>)
//        
//        public enum Alert: Equatable {
//            case dismissAlert
//        }
//    }
//    
//    // MARK: - Reducer Body
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .presentAlert:
//                state.alertMessage = "Nie udana próba logowania"
//                state.alert = .infoAlert(message: state.alertMessage)
//                
////                state.alert = AlertState {
////                    TextState("Uwaga")
////                } actions: {
////                    ButtonState(role: .cancel, action: .send(.dismissAlert)) {
////                        TextState("Anuluj")
////                    }
////                } message: {
////                    TextState("Czy na pewno chcesz usunąć wiadomość?")
////                }
//                
//                return .none
//                
//            case .view(.presentAlertTapped):
//                return .run { send in
//                    await send(.presentAlert)
//                }
//                
//            default:
//                return .none
//            }
//        }
//    }
//}
//
//
////extension AlertState where Action == ScreenAlert.Action.Alert {
////    static let infoAlert = Self {
////        TextState("Uwaga")
////    } actions: {
////        ButtonState(role: .cancel, action: .send(.dismissAlert)) {
////            TextState("OK")
////        }
////    } message: {
////        TextState("Logowanie nie udane")
////    }
////}
//
//extension AlertState where Action == ScreenAlert.Action.Alert {
//    static func infoAlert(message: String) -> Self {
//        Self {
//            TextState("Uwaga")
//        } actions: {
//            ButtonState(role: .cancel, action: .send(.dismissAlert)) {
//                TextState("OK")
//            }
//        } message: {
//            TextState(message)
//        }
//    }
//}
//
//@ViewAction(for: ScreenAlert.self)
//struct ScreenAlertView: View {
//    
//    @Bindable var store: StoreOf<ScreenAlert>
//    
//    var body: some View {
//        button
//    }
//    
//    @ViewBuilder
//    var button: some View {
//        Button {
//            send(.presentAlertTapped)
//        } label: {
//            Text("Button")
//        }
//        .alert(store: store.scope(state: \.$alert, action: \.alert))
//    }
//}
