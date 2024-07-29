//
//  ChatView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages, id: \.content) { message in
                    messageView(message)
                }
            }
        }
        
        HStack {
            TextField("Enter a message...", text: $viewModel.messageInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                Task {
                    try await viewModel.sendMessage()
                }
            } label: {
                 Text("send")
            }
        }
        .padding()
        
    }
    
    private func messageView(_ message: Message) -> some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.blue : Color.gray)
                .foregroundStyle(.white)
                .cornerRadius(8)
            if message.role == .assistant {
                Spacer()
            }
        }
        .padding()
    }
    
}
