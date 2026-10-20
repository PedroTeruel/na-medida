//
//  MeasureData.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 20/10/26.
//

import Foundation

struct LiquidMeasure: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let value: String
}

struct SolidMeasure: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let cup: String
    let spoon: String
}

enum MeasureData {
    static let liquidMeasures: [LiquidMeasure] = [
        .init(name: "1 Xícara de Chá", value: "250"),
        .init(name: "1/2 Xícara de Chá", value: "120"),
        .init(name: "1/4 Xícara de Chá", value: "60"),
        .init(name: "1 Colher de Sopa", value: "15"),
        .init(name: "1 Colher de Chá", value: "5")
    ]
    
    static let solidMeasures: [SolidMeasure] = [
        .init(name: "Farinha de Trigo", cup: "120 g", spoon: "8 g"),
        .init(name: "Açúcar Refinado", cup: "200 g", spoon: "12 g"),
        .init(name: "Açúcar Mascavo", cup: "150 g", spoon: "10 g"),
        .init(name: "Margarina", cup: "200 g", spoon: "15 g"),
        .init(name: "Cacau em Pó", cup: "90 g", spoon: "6 g"),
        .init(name: "Aveia em Flocos", cup: "80 g", spoon: "5 g"),
        .init(name: "Arroz Cru", cup: "200 g", spoon: "15 g")
    ]
    
    static let sauceMeasures: [SolidMeasure] = [
        .init(name: "Sal Fino", cup: "15 g", spoon: "5 g"),
        .init(name: "Sal Grosso", cup: "20 g", spoon: "7 g"),
        .init(name: "Fermento", cup: "12 g", spoon: "4 g"),
        .init(name: "Bicarbonato", cup: "14 g", spoon: "5 g"),
        .init(name: "Especiarias", cup: "6 g", spoon: "2 g"),
        .init(name: "Ervas", cup: "3 g", spoon: "1 g")
    ]
}
