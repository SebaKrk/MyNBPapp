//
//  OpenAIServices.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/07/2024.
//

import Foundation
import Alamofire

enum OpenAINetworkingError: String, Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case requestFailed
    case unknownError
    case noMessage
}

enum Constant: String {
    case apiKey = "MY_API_KEY"
}

class OpenAIServices {
    
    private let endPointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(message: [Message]) async throws -> OpenAIResponse? {
        
        // Krok 1: Określ adres URL
        guard let url = URL(string: endPointURL) else {
            throw OpenAINetworkingError.invalidURL
        }
        
        // Krok 2: Przygotowanie danych body
        let requestBody = OpenAIRequest(model: "gpt-4",
                                        messages: message,
                                        maxTokens: 10)
        
        // Krok 3: Kodowanie danych do formatu JSON
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        let jsonData = try encoder.encode(requestBody)
        
        // Krok 4a: Tworzenie żądania URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Krok 4b: Definiowanie nagłówków w słowniku
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(Constant.apiKey)"
        ]
        
        // Krok 4c: Ustawianie nagłówków w żądaniu
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = jsonData
        
        // Krok 5: Wykonanie żądania za pomocą URLSession
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Krok 6: Sprawdzenie odpowiedzi
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw OpenAINetworkingError.invalidResponse
        }
        
        // Krok 7: Dekodowanie odpowiedzi
        do {
            let chatResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            return chatResponse
        } catch {
            throw OpenAINetworkingError.decodingError
        }
    }
}

//curl https://api.openai.com/v1/chat/completions \
//  -H "Content-Type: application/json" \
//  -H "Authorization: Bearer $OPENAI_API_KEY" \
//  -d '{
//    "model": "gpt-4o",
//    "messages": [
//      {
//        "role": "system",
//        "content": "You are a helpful assistant."
//      },
//      {
//        "role": "user",
//        "content": "Hello!"
//      }
//    ]
//  }'


//{
//  "id": "chatcmpl-123",
//  "object": "chat.completion",
//  "created": 1677652288,
//  "model": "gpt-4o-mini",
//  "system_fingerprint": "fp_44709d6fcb",
//  "choices": [
//    {
//    "index": 0,
//    "message": {
//      "role": "assistant",
//      "content": "\n\nHello there, how may I assist you today?",
//    },
//    "logprobs": null,
//    "finish_reason": "stop"
//  }],
//  "usage": {
//    "prompt_tokens": 9,
//    "completion_tokens": 12,
//    "total_tokens": 21
//  }
//}


//struct ChatRequest: Codable {
//    let model: String
//    let messages: [Message2]
//    let max_tokens: Int
//    let temperature: Double
//    let top_p: Double
//    let n: Int
//    let stop: [String]?
//    let presence_penalty: Double
//    let frequency_penalty: Double
//}
//        let headers: HTTPHeaders = [
//            "Content-Type" : "application/json",
//            "Authorization" : "Bearer \(apiKey)"
//        ]
//
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        

//enum Constants {
//    static let openAIApiKey = ""
//}
