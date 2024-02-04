//
//  Formatters+Date.swift
//
//
//  Created by Sebastian Sciuba on 04/02/2024.
//

import Foundation

extension Formatters {
    
    public class Date {
        
        // MARK: - Properties
        
        static let dateFormatter = DateFormatter()
        
        // MARK: - Lifecycle
        
        public init() {}
        
        // MARK: - API
        
        /// Function which converts the specified date into a string of the desired format
        ///
        /// - Parameter date: The date we want to convert to the chosen string
        ///
        /// - Parameter format: DateFormat type to which we want to convert the selected date
        ///
        /// - Returns: Returns the converted string
        public static func createString(from date: Foundation.Date, with format: DateFormat) -> String {
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.string(from: date)
        }
        
        /// Function which converts the specified string into a date of the desired format
        ///
        /// - Parameter dateString: The string we want to convert to the chosen formatted date
        ///
        /// - Parameter format: DateFormat type to which we want to convert the selected date
        ///
        /// - Returns: Returns the converted date
        public static func createDate(from dateString: String, with format: DateFormat) -> Foundation.Date? {
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.date(from: dateString)
        }
        
        /// Function which create `DateFormatter` with specific date format
        ///
        /// - Parameter dateFormat: DateFormat type to which we want to convert the selected date
        ///
        /// - Returns: Returns `DateFormatter`
        public static func createDateFormatter(with dateFormat: DateFormat) -> DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat.rawValue
            return dateFormatter
        }
    }
    
}
