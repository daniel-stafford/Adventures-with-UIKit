//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/26/21.
//

import Foundation
//in order for ShapeStyle to work
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
