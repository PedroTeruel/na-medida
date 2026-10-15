//
//  NutrientData.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 08/10/26.
//

import SwiftUI
import Foundation

let nutrients: [Nutrient] = [
    
    Nutrient(
        name: "Gorduras Totais",
        image: "FatIcon",
        description: "Energia, hormônios e absorção de vitaminas",
        
        generalBody:
            "As gorduras (lipídios) são um grupo de nutrientes que fornecem energia, participam da produção de hormônios e ajudam na absorção de vitaminas lipossolúveis (A, D, E e K).",
        generalCap: "Fornecem 9 calorias por grama, sendo o nutriente mais calórico.",
        generalColor: .yellow,
        
        functions: [
            NutrientFunction(
                icon: "RayIcon",
                text: "Fonte de energia"
            ),
            NutrientFunction(
                icon: "HeartIcon",
                text: "Produção de hormônios"
            ),
            NutrientFunction(
                icon: "ShieldIcon",
                text: "Absorção de vitaminas A, D, E e K"
            )
        ],
        
        sources: [
            NutrientFonts(icon: "sourceAzeite", text: "Azeite de Oliva"),
            NutrientFonts(icon: "sourceAbacate", text: "Abacate"),
            NutrientFonts(icon: "sourcePeixe", text: "Peixes gordurosos")            
        ]
    ),
    
    Nutrient(
        name: "Carboidratos",
        image: "CarbIcon",
        description: "Principal fonte de energia do corpo",
        
        generalBody:
            "Os carboidratos são a principal fonte de energia rápida para o organismo. Eles são transformados em glicose, utilizada principalmente pelo cérebro e pelos músculos.",
        generalCap: "Fornecem 4 calorias por grama e são a principal fonte de energia rápida do corpo.",
        generalColor: .orange,
        
        functions: [
            NutrientFunction(
                icon: "RayIcon",
                text: "Fonte primária de energia"
            ),
            NutrientFunction(
                icon: "BrainIcon",
                text: "Fornecimento de glicose ao cérebro"
            ),
            NutrientFunction(
                icon: "MuscleIcon",
                text: "Suporte às atividades físicas"
            )
        ],
        
        sources: [
            NutrientFonts(icon: "sourcePao", text: "Pães"),
            NutrientFonts(icon: "sourceMassas", text: "Massas"),
            NutrientFonts(icon: "sourceBatata", text: "Batata")
        ]
    ),
    
    Nutrient(
        name: "Calorias",
        image: "CaloriesIcon",
        description: "Energia que o corpo utiliza",
        
        generalBody:
            "Calorias representam a quantidade de energia fornecida pelos alimentos. Essa energia é utilizada pelo organismo para manter suas funções vitais e realizar atividades ao longo do dia.",
        generalCap: "As calorias indicam quanta energia um alimento fornece ao organismo.",
        generalColor: .red,
        
        functions: [
            NutrientFunction(
                icon: "RayIcon",
                text: "Fornecimento de energia"
            ),
            NutrientFunction(
                icon: "KeyIcon",
                text: "Manutenção das funções do organismo"
            )
        ],
        
        sources: [
            NutrientFonts(icon: "sourceCarbo", text: "Carboidratos"),
            NutrientFonts(icon: "sourceProteinas", text: "Proteínas"),
            NutrientFonts(icon: "sourceGorduras", text: "Gorduras")
        ]
    ),
    
    Nutrient(
        name: "Proteínas",
        image: "ProtIcon",
        description: "Construção muscular e reparo dos tecidos",
        
        generalBody:
            "As proteínas são nutrientes formados por aminoácidos e participam da construção, manutenção e reparação dos tecidos do organismo.",
        generalCap: "Fornecem 4 calorias por grama e participam da construção e reparo dos tecidos.",
        generalColor: .mint,
        
        functions: [
            NutrientFunction(
                icon: "MuscleIcon",
                text: "Construção muscular"
            ),
            NutrientFunction(
                icon: "ShieldIcon",
                text: "Reparo dos tecidos"
            )
        ],
        
        sources: [
            NutrientFonts(icon: "sourceCarnes", text: "Carnes"),
            NutrientFonts(icon: "sourceOvos", text: "Ovos"),
            NutrientFonts(icon: "sourceLeite", text: "Leite"),
        ]
    ),
    
    Nutrient(
        name: "Sódio",
        image: "SodiumIcon",
        description: "Equilíbrio de fluidos e função nervosa",
        
        generalBody:
            "O sódio é um mineral importante para o equilíbrio dos líquidos do corpo e para o funcionamento adequado dos músculos e nervos.",
        generalCap: "O consumo excessivo de sódio pode contribuir para o aumento da pressão arterial.",
        generalColor: .gray,
        
        functions: [
            NutrientFunction(
                icon: "WaterIcon",
                text: "Equilíbrio de fluidos"
            ),
            NutrientFunction(
                icon: "RayIcon",
                text: "Transmissão de impulsos nervosos"
            )
        ],
        
        sources: [
            NutrientFonts(icon: "sourceSal", text: "Sal de cozinha"),
            NutrientFonts(icon: "sourceQueijo", text: "Queijos"),
            NutrientFonts(icon: "sourceConservas", text: "Conservas")
        ]
    )
]
