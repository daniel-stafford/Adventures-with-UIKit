//
//  Petition.swift
//  WhiteHousePetitions
//
//  Created by Daniel Stafford on 1/4/22.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
