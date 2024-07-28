//
//  ChatViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI
import Alamofire

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
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

enum Constants {
    static let openAIApiKey = ""
}

class OpenAIServices {
    
    private let endPointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map { OpenAIChatMessage(role: $0.role, content: $0.content)}
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Constants.openAIApiKey)"
        ]
        
        return try? await AF.request(endPointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
    
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let creatAt: Date
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Codable {
    let choice: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Codable {
    let message: OpenAIChatMessage
}
