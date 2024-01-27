//
//  FlagView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import SwiftUI

struct FlagView: View {
    
    var name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
            .frame(height: 25)
    }
    
}
