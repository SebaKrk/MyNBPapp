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

public struct ExchangeRateClient {
    
    let client: Client
    let transport: ClientTransport = URLSessionTransport()
    
    public init() {
        self.client = Client(serverURL: try! Servers.server1(),
                             transport: transport)
    }
    
    public func getData() async throws  -> [String : Double] {
        let response = try await client.get_sol_latest_sol__lcub_base_currency_rcub_(path: .init(base_currency: "PLN"))
 
        switch response {
            
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let json):
                if let data = json.rates?.additionalProperties {
                    return data
                } else {
                    return [:]
                }
            }
            
        case .notFound(_):
            print("not found")
            return [:]
        case .undocumented(statusCode: let statusCode, _):
            print("Undocumented status code: \(statusCode)")
            return [:]
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

//ok(GreetingServiceClient.Operations.getGreeting.Output.Ok(
//headers: GreetingServiceClient.Operations.getGreeting.Output.Ok.Headers(),
//body: GreetingServiceClient.Operations.getGreeting.Output.Ok.Body.json(
//GreetingServiceClient.Components.Schemas.Greeting(message: "Hello, CLI"))))
