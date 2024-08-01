//
//  ChatModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/07/2024.
//

import Foundation

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
