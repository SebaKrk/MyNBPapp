//
//  LoadingDotsView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/07/2024.
//

import SwiftUI

struct LoadingDotsView: View {
    @State private var isAnimating: Bool = true

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .padding(.all, 10)
        .frame(width: 80,height: 40)
        .background(Color.gray.opacity(0.3))
        .clipShape(.capsule)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoadingDotsView()
}
