//
//  ChatView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/07/2024.
//

import SwiftUI

struct ChatView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ChatViewModel
    
    // MARK: Lifecycle
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages, id: \.content) { message in
                    messageView(message)
                }
                if viewModel.isLoading {
                    loadingView()
                }
            }
        }
        HStack {
            messageTextField
            sendButton
        }
        .padding()
    }
    
    // MARK: - Subview
    
    private func messageView(_ message: Message) -> some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.blue : Color.gray.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(14)
            if message.role == .assistant {
                Spacer()
            }
        }
        .padding()
    }
    
    private var messageTextField: some View {
        TextField("Enter a message...", text: $viewModel.messageInput)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var sendButton: some View {
        Button {
            Task {
                try await viewModel.sendMessage()
            }
        } label: {
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
    
    private func loadingView() -> some View {
        HStack {
            LoadingDotsView()
            Spacer()
        }
        .padding()
    }
}
