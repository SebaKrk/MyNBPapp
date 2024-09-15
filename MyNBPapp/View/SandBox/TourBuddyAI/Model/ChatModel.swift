//
//  ChatModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/07/2024.
//

import Foundation


struct OpenAIRequest: Codable {
    let model: String
    let messages: [Message]
    let maxTokens: Int // max_tokens
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}
