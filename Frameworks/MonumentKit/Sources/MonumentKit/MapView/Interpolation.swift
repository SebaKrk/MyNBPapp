//
//  Interpolation.swift
//
//
//  Created by Sebastian Sciuba on 26/01/2024.
//

import Foundation

public extension ClosedRange where Bound: BinaryFloatingPoint {
    /// Returns a value between this range's lower and upper bounds, valued by a percentage between the two.
    /// - Parameters:
    ///   - percent: The percentage between lower and upper bound.
    ///   - clamped: Ignores values outside `0...1`, defaults to `true`.
    /// - Returns: A value between lower and upper bound.
    func value(percent: Bound, clamped: Bool = true) -> Bound {
        var percent = percent
        if clamped {
            percent = Swift.min(Swift.max(percent, 0), 1)
        }
        return (1 - percent) * lowerBound + percent * upperBound
    }
    
    /// Returns the percentage of `value` as it lays between this bound's lower and upper bounds.
    /// - Parameters:
    ///   - value: A value between this range's lower and upper bounds.
    ///   - clamped:Clamps the result between `0...1`, defaults to `true`.
    /// - Returns: A value between 0 and 1.
    func percent(for value: Bound, clamped: Bool = true) -> Bound {
        var result = (value - lowerBound) / (upperBound - value)
        if clamped {
            result = Swift.min(Swift.max(result, 0), 1)
        }
        return result
    }
}

public extension BinaryFloatingPoint {
    /// Returns a value that smoothly ramps from 0 to 1, useful for animation purposes.
    ///
    /// > Important: Only call this method on a finite number.
    /// - Parameter clamped: Ignores values outside `0...1`, defaults to `true`.
    /// - Returns: A value that is easing from 0 to 1.
    func easeInOut(clamped: Bool = true) -> Self {
        assert(self.isFinite)
        let timing = clamped ? min(max(self, 0), 1) : self
        return timing * timing * (3.0 - 2.0 * timing)
    }
    
    /// Takes a value from 0 to 1 and returns a value that starts at 0, eases into 1, and eases back into 0.
    ///
    /// For example, the following inputs generate these outputs:
    /// Input  | Output
    /// --- | ---
    /// `0` | `0`
    /// `0.25` | `0.5`
    /// `0.5` | `1`
    /// `0.75` | `0.5`
    /// `1` | `0`
    ///
    /// > Important: Only call this method on a finite number.
    /// - Parameter clamped: Ignores values outside `0...1`, defaults to `true`.
    /// - Returns: A value that is easing from 0 to 1 and back to 0.
    func symmetricEaseInOut(clamped: Bool = true) -> Self {
        assert(self.isFinite)
        let timing = clamped ? min(max(self, 0), 1) : self
        if timing <= 0.5 {
            return (timing * 2).easeInOut(clamped: clamped)
        } else {
            return (2 - (timing * 2)).easeInOut(clamped: clamped)
        }
    }
    
    /// Truncates a value by `truncation` and returns the percentage between that value and `truncation` itself.
    ///
    /// If this value is 175 and you pass 50 for the `truncation` value, this would return 0.5 as it is 50% towards the next `truncation` value.
    ///
    /// > Important: Only call this method on a finite number.
    /// - Parameter truncation: A truncation value that also determines the percentage.
    /// - Returns: A value from 0 to 1.
    func percent(truncation: Self) -> Self {
        assert(self.isFinite)
        assert(!truncation.isZero && truncation.isFinite)
        return self.truncatingRemainder(dividingBy: truncation) / truncation
    }
    
}
