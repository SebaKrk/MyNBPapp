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
                ForEach(viewModel.messages.filter { $0.role != .system }, id: \.id) { message in
                    messageView(message)
                }
            }
        }
        
        HStack {
            TextField("Enter a message...", text: $viewModel.currentInput)
            Button {
                viewModel.sendMessage()
            } label: {
                 Text("send")
            }
        }
        
    }
    
    private func messageView(_ message: Message) -> some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.blue : Color.gray)
            if message.role == .assistant {
                Spacer()
            }
        }
    }
    
}
