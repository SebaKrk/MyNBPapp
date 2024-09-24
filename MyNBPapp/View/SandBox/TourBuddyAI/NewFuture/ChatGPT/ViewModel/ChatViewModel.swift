//
//  ChatViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI


class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
//    = [OpenAIMessage(role: "system", content: "You are coding assistant. You will help me understand how to write only Swift code. You do not have enough information about other languages to give advice so avoid doing so at ALL times") ]

    @Published var messageInput: String = ""
    @Published var isLoading: Bool = false
    
    @Published var openMapView: Bool = false
    
    private let service = OpenAIServices()
    
    @MainActor
    func sendMessage() async throws {
        let newMessage = Message(role: .user , content: messageInput)
        messages.append(newMessage)
        messageInput = ""
        isLoading = true
        
        do {
            let response = try await service.sendMessage(message: messages)
            guard let receivedOpenAIMessage = response?.choices.first?.message else {
                throw OpenAINetworkingError.noMessage
            }
            
            let receivedMessage = Message(role: receivedOpenAIMessage.role,
                                                content: receivedOpenAIMessage.content)
            messages.append(receivedMessage)
        } catch {
            throw OpenAINetworkingError.requestFailed
        }
        
        isLoading = false
    }
}
