//
//  Recipe.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 29/09/26.
//

import Foundation
import SwiftData

@Model
final class Recipe{
    var name: String
    var creationDate: Date
    
    init(name: String, creationDate: Date = .now) {
        self.name = name
        self.creationDate = creationDate
    }
}
