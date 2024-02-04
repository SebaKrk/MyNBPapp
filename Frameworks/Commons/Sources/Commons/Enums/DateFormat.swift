//
//  DateFormat.swift
//
//
//  Created by Sebastian Sciuba on 04/02/2024.
//

import Foundation

/// Structure representing the date and time formats available in the application
public enum DateFormat: String {
    
    // MARK: - Presentation
    
    /// Date format: **EEEE, d MMMM yyyy**
    ///
    /// Example: **poniedziałek, 13 lutego 2017**
    case date = "EEEE, d MMMM yyyy"

    /// Date format: **EEEE, d MMMM yyyy HH:mm:ss**
    ///
    /// Example: **poniedziałek, 13 lutego 2017 13:12**
    case dateAndTime = "EEEE, d MMMM yyyy HH:mm"
    
    /// Date format: **dd.MM.yyyy HH:mm**
    ///
    /// Example: **13.02.2017 13:12**
    case shortDateAndTime = "dd.MM.yyyy HH:mm"
    
    /// Date format: **dd.MM.yyyy**
    ///
    /// Example: **13.02.2017**
    case shortDateInts = "dd.MM.yyyy"
    
    /// Date format: **yyyy-MM-dd**
    ///
    /// Example: **2023-10-24**
    case shortDate = "yyyy-MM-dd"
    
    /// Date format: **dd MMMM**
    ///
    /// Example: **09 lutego**
    case dayAndMonth = "dd MMMM"

    /// Date format: **dd MMM**
    ///
    /// Example: **09 lut**
    case dayAndShortMonth = "dd MMM"
    
    /// Date format: **dd.MM**
    ///
    /// Example: **13.11**
    case dayAndShortMonthAsInts = "dd.MM"
    
    /// Date format: **HH:mm**
    ///
    /// Example: **13:12**
    case time = "HH:mm"
    
    /// Date format: **dd**
    ///
    /// Example **7**
    case day = "d"
    
    /// Date format: **d**
    ///
    /// Example **07**
    case dayWithLeadingZero = "dd"
    
    /// Date format **MMMM yyyy**
    ///
    /// Example **stycznia 2020**
    case monthAndYear = "MMMM yyyy"
    
    /// Date format **EEEE**
    ///
    /// Example **czwartek**
    case weekday = "EEEE"
    
    /// Date format **E**
    ///
    /// Example **pon.**
    case dayName = "E"
    
    /// Date format **LLLL y**
    ///
    /// Example **styczeń 2019**
    case month = "LLLL y"
    
}
