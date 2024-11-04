//
//  DataDecoder.swift
//  Services
//
//  Created by Sebastian Sciuba on 04/11/2024.
//

import Foundation

struct DataDecoder<T: Decodable> {
    func decode(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
