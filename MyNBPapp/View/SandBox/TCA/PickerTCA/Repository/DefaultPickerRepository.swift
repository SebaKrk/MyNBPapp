//
//  DefaultPickerRepository.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Factory
import Foundation
import DataModels

public final class DefaultPickerRepository: PickerRepository {
    
    // MARK: - Dependencies
    
    @LazyInjected(\.nbpService) private var service
    
    // MARK: - API
    
    public func fetchDataFormNBP(period: Period) async throws -> Exchange {
        
        try await service.makeTestRequestFromNBP(period.dateFrom,
                                                 period.dateTo)
    }
    
}
