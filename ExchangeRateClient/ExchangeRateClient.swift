//
//  ExchangeRateClient.swift
//  ExchangeRateClient
//
//  Created by Sebastian Sciuba on 12/02/2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

public struct ExchangeRatesResponse: Codable {
    public let base: String?
    public let date: String?
    public let rates: [String: Double]?
    public let timeLastUpdated: Int?

    public init(base: String?, date: String?, rates: [String : Double]?, timeLastUpdated: Int?) {
        self.base = base
        self.date = date
        self.rates = rates
        self.timeLastUpdated = timeLastUpdated
    }
    
    enum CodingKeys: String, CodingKey {
        case base, date, rates
        case timeLastUpdated = "time_last_updated"
    }
}

public struct ExchangeRateClient {
    
    let client: Client
    let transport: ClientTransport = URLSessionTransport()
    
    public init() {
        self.client = Client(serverURL: try! Servers.server1(),
                             transport: transport)
    }
    
    
    public func getData() async throws  {
        let response = try await client.get_sol_latest_sol__lcub_base_currency_rcub_(path: .init(base_currency: "PLN"))
        
        switch response {
            
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let json):
                dump(json)
            }
            
        case .notFound(_):
            print("not found")
        case .undocumented(statusCode: let statusCode, _):
            print("Undocumented status code: \(statusCode)")
        }
    }
}

//        get_sol_latest_sol__lcub_base_currency_rcub_()
//        get_sol_latest_sol__lcub_base_currency_rcub_(path: )
//        get_sol_latest_sol__lcub_base_currency_rcub_(path: ,headers:)

//                let exchangeRates = try JSONDecoder().decode(ExchangeRatesResponse.self, from: json)
//                let decoder = JSONDecoder()
//                let exchangeRates = try decoder.decode(ExchangeRatesResponse.self, from: <#T##Data#>)
//                return exchangeRates
