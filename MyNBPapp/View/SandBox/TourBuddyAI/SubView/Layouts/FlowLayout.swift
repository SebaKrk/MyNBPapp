//
//  FlowLayout.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    // Layout function to calculate size and offsets
    func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> (size: CGSize, offsets: [CGPoint]) {
        var offsets: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var maxHeightInRow: CGFloat = 0
        
        for size in sizes {
            if currentX + size.width > containerWidth {
                // Move to the next line
                currentX = 0
                currentY += maxHeightInRow + spacing
                maxHeightInRow = 0
            }
            
            offsets.append(CGPoint(x: currentX, y: currentY))
            currentX += size.width + spacing
            maxHeightInRow = max(maxHeightInRow, size.height)
        }
        
        let totalHeight = currentY + maxHeightInRow
        return (CGSize(width: containerWidth, height: totalHeight), offsets)
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.width ?? .infinity
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, spacing: spacing, containerWidth: containerWidth).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, spacing: spacing, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
}
