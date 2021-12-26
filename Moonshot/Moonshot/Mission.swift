//
//  Mission.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/26/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    // nested struct for organization
    struct CrewMember: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewMember]
    let description: String
}
