//
//  OpenAIServices.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/07/2024.
//

import Foundation
import Alamofire

enum Constants {
    static let openAIApiKey = ""
}

class OpenAIServices {
    
    private let endPointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map { OpenAIChatMessage(role: $0.role, content: $0.content)}
        
        let body = OpenAIChatBody(model: "gpt-4", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Constants.openAIApiKey)"
        ]
        
        return try? await AF.request(endPointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
    
}
