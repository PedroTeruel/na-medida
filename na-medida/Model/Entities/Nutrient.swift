//
//  Nutrient.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import Foundation
import SwiftUI

struct Nutrient: Identifiable, Hashable {

    let id = UUID()

    let name: String
    let image: String
    let description: String

    let generalBody: String
    let generalCap: String
    let generalColor: Color

    let functions: [NutrientFunction]
    let sources: [String]
}

struct NutrientFunction: Identifiable, Hashable {

    let id = UUID()

    let icon: String
    let text: String
}
