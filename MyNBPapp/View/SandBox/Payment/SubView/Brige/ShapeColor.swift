//
//  ShapeColor.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 27/09/2024.
//

import SwiftUI

/// The `ShapeColor` protocol defines a `paint()` method that returns a color.
/// Implementations of this protocol can define any SwiftUI color, which can be used
/// for styling views, buttons, or other UI components.
///
/// ### Example Usage:
/// ```swift
/// struct ExampleView: View {
///     let color: ShapeColor
///
///     var body: some View {
///         Text("Example")
///             .foregroundColor(color.paint()) // Using the color from the protocol
///             .padding()
///     }
/// }
///
/// // Example of implementing the ShapeColor protocol
/// class RedColor: ShapeColor {
///     func paint() -> Color {
///         return .red
///     }
/// }
///
/// struct ContentView: View {
///     var body: some View {
///         ExampleView(color: RedColor())  // Using the red color
///     }
/// }
/// ```
///
/// The `ShapeColor` protocol can be implemented by various classes to provide
/// different color styles, making the code more flexible and reusable.
protocol ShapeColor {
    func paint() -> Color
}
