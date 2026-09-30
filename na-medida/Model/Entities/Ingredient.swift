//
//  IngredientEntity.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 29/09/26.
//
import Foundation
import SwiftData

// tipo de unidade do ingrediente
//enum MeasuringUnit: String, Codable, CaseIterable {
//    case grams = "g"
//    case kilograms = "Kg"
//    case milliliters = "mL"
//    case liters = "L"
//    case unit = "un"
//    
//    var toBaseFactor: Double {
//        switch self {
//        case .grams, .milliliters, .unit:
//            return 1.0
//        case .kilograms, .liters:
//            return 1000.0
//        }
//    }
//}


@Model
final class Ingredient {
    var barcode: String?
    var id: UUID
    var name: String
    var brand: String?
    var photoURL: String?
    var caloriesPer100g: Double
    var proteinsPer100g: Double
    var carbsPer100g: Double
    var fatsPer100g: Double
//    var userQuantity: Double
//    var selectedUnit: MeasuringUnit

    init(
        barcode: String?,
        id: UUID = UUID(),
        name: String,
        brand: String? = nil,
        photoURL: String? = nil,
        caloriesPer100g: Double = 0.0,
        proteinsPer100g: Double = 0.0,
        carbsPer100g: Double = 0.0,
        fatsPer100g: Double = 0.0,
        userQuantity: Double
//        , selectedUnit: MeasuringUnit = .grams
    ) {
        self.barcode = barcode
        self.id = id
        self.name = name
        self.brand = brand
        self.photoURL = photoURL
        self.caloriesPer100g = caloriesPer100g
        self.proteinsPer100g = proteinsPer100g
        self.carbsPer100g = carbsPer100g
        self.fatsPer100g = fatsPer100g
        self.userQuantity = userQuantity
//        self.selectedUnit = selectedUnit
    }
}

// 3. Extensões (Cálculos e Construtor do DTO)
//extension Ingredient {
//    var baseQuantity: Double {
//        return userQuantity * selectedUnit.toBaseFactor
//    }
//    
//    private var multiplier: Double {
//        return baseQuantity / 100.0
//    }
//    
//    var totalCalories: Double { caloriesPer100g * multiplier }
//    var totalProteins: Double { proteinsPer100g * multiplier }
//    var totalCarbs: Double { carbsPer100g * multiplier }
//    var totalFats: Double { fatsPer100g * multiplier }
//    
//    convenience init(dto: ProductOpenFoodFactsDTO, userQuantity: Double, selectedUnit: MeasuringUnit) {
//        self.init(
//            name: dto.productName ?? "Produto sem nome",
//            brand: dto.brands,
//            photoURL: dto.fotoProdutoURL,
//            caloriesPer100g: dto.nutriments?.energyKcal100g ?? 0.0,
//            proteinsPer100g: dto.nutriments?.proteins100g ?? 0.0,
//            carbsPer100g: dto.nutriments?.carbohydrates100g ?? 0.0,
//            fatsPer100g: dto.nutriments?.fat100g ?? 0.0,
//            userQuantity: userQuantity,
//            selectedUnit: selectedUnit
//        )
//    }
//}
