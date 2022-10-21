//
//  Country.swift
//  CountryBlast
//
//  Created by Daniel Stafford on 1/12/22.
//

import Foundation

struct Country: Codable {
    var name: Name
    struct Name: Codable {
        var common: String
        var official: String
    }

    var population: Int

    var cca2: String

    var flags: Flags
    struct Flags: Codable {
        var png: String
    }

    var car: Car
    struct Car: Codable {
        var side: String
    }
    var region: String?
    var subregion: String?
    var landlocked: Bool
    var capital: [String]?
}
