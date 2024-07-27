//
//  ChatViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    
    func sendMessage() {
        
    }
}

enum Constants {
    static let openAIApiKey = ""
}

class OpenAIServices {
    
    private let endPointURL = "https://api.openai.com/v1/chat/completions"
    
//    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
//        let openAIMessages = messages.map { OpenAIChatMessage(role: $0.role, content: $0.content)}
//        
//        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
//        let headers: HTTPHeaders = [
//            "Authorization" : "Bearer \(Constants.openAIApiKey)"
//        ]
//        
//        return try? await
//    }
    
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
