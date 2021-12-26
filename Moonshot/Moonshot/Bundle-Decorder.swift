//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/26/21.
//

import Foundation

extension Bundle {
    // ensure are placeholder, T, conforms to codable protocol
    // note Codable = Encodable & Decodable
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
