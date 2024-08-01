//
//  ChatViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI
import Alamofire

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: "You are coding assistant. You will help me understand how to write only Swift code. You do not have enough information about other languages to give advice so avoid doing so at ALL times", creatAt: Date())]
    @Published var currentInput: String = ""
    
    private let openAIServices = OpenAIServices()
    
    func sendMessage() {
        let newMessage = Message(id: UUID(), role: .user, content: currentInput, creatAt: Date())
        messages.append(newMessage)
        currentInput = ""
        
        Task {
            let response = await openAIServices.sendMessage(messages: messages)
            guard let receivedOpenAIMessage = response?.choice.first?.message else {
                print("No received message")
                return
            }
            let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, creatAt: Date())
            await MainActor.run {
                messages.append(receivedMessage)
            }
        }
    }
}
