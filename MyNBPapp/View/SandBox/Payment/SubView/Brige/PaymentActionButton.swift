//
//  File.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/09/2024.
//

import SwiftUI

struct PaymentActionButton: View {
    
    let title: String
    let color: ShapeColor
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundStyle(color.paint())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color.paint(), lineWidth: 2)
                )
        }
    }
}
