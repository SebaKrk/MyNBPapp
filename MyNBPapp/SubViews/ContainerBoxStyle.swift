//
//  ContainerBoxStyle.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 28/09/2024.
//

import SwiftUI

struct ContainerBoxStyle: GroupBoxStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .frame(height: 50)
            configuration.content
        }
        .padding()
        .background(color)
        .cornerRadius(8)
    }
    
}
