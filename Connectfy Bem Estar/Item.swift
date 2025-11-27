//
//  Item.swift
//  Connectfy Bem Estar
//
//  Created by Fernando Araujo Ribeiro on 27/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
