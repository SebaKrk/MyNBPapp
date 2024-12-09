//
//  DefaultService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Factory
import Foundation
import DataModels

final class DefaultService: PickerService {

    // MARK: - Dependencies
    
    @LazyInjected(\.pickerRepository) private var repository
    
    // MARK: - API
    
    func fetchDataFormNBP(_ period: Period) async throws -> Exchange {
       try await repository.fetchDataFormNBP(period: period)
    }
    
    func getPeriod() -> Period {
        Period(dateFrom: "2024-01-02", dateTo: "2024-01-31")
    }
    
    func getPeriods() -> Periods {
        Periods(current:  Period(dateFrom: "2024-11-01", dateTo: "2024-11-30"),
                previous:  Period(dateFrom: "2024-12-01", dateTo: "2024-12-31"))
    }
}
