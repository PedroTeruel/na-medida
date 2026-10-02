//
//  NutritionFacts.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 01/10/26.
//
//import SwiftUI
//
//struct NutritionFactsTable: View {
//    // Array de itens já formatados vindo do DTO
//    let items: [NutritionalFactsItem]
//    
//    // Permite personalizar as informações do cabeçalho da porção
//    var servingText: String = "Porção"
//    
//    var body: some View {
//        VStack(spacing: 6) {
//            // MARK: - Cabeçalho da Tabela
//            headerView
//            
//            Divider()
//                .background(Color.primary)
//            
//            // MARK: - Linhas de Nutrientes
//            ForEach(items) { item in
//                rowView(for: item)
//                
//                Divider()
//                    .opacity(0.5)
//            }
//            
//            // Rodapé explicativo do %VD conforme Anvisa
//            HStack {
//                Text("* % Valores Diários com base em uma dieta de 2.000 kcal.")
//                    .font(.system(size: 14))
//                    .foregroundColor(.primary)
//                Spacer()
//            }
//            .padding(.top, 8)
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//        )
//    }
//    
//    // MARK: - View do Cabeçalho
//    private var headerView: some View {
//        VStack {
//            Text("Informação Nutricional")
//                .font(.system(.title, weight: .bold))
//                .foregroundColor(Color("buttonColor"))
//            
//            Text("")
//            
//            Spacer()
//            
//            HStack(spacing: 16) {
//                Text("100 g")
//                    .font(.system(.caption, weight: .bold))
//                    .foregroundColor(.primary)
//                    .frame(width: 50, alignment: .trailing)
//                
//                Text(servingText)
//                    .font(.system(.caption, weight: .bold))
//                    .foregroundColor(.primary)
//                    .frame(width: 50, alignment: .trailing)
//                
//                Text("%VD *")
//                    .font(.system(.caption, weight: .bold))
//                    .foregroundColor(.primary)
//                    .frame(width: 40, alignment: .trailing)
//            }
//        }
//        .padding(.vertical, 8)
//    }
//    
//    // MARK: - View de cada Linha (Row)
//    private func rowView(for item: NutritionalFactsItem) -> some View {
//        HStack {
//            // Nome do nutriente (aplica recuo se for sub-item e negrito se configurado)
//            Text(item.name)
//                .font(.system(.subheadline, weight: item.isBold ? .bold : .regular))
//                .foregroundColor(.primary)
//                .padding(.leading, item.isIndent ? 16 : 0)
//            
//            Spacer()
//            
//            // Valores formatados
//            HStack(spacing: 16) {
//                Text(item.value100g)
//                    .font(.system(.subheadline, weight: item.isBold ? .bold : .regular))
//                    .foregroundColor(.primary)
//                    .frame(width: 50, alignment: .trailing)
//                
//                Text(item.valuePortion)
//                    .font(.system(.subheadline, weight: item.isBold ? .bold : .regular))
//                    .foregroundColor(.primary)
//                    .frame(width: 50, alignment: .trailing)
//                
//                Text(item.dailyValue.isEmpty ? "-" : "\(item.dailyValue)%")
//                    .font(.system(.subheadline, weight: item.isBold ? .bold : .regular))
//                    .foregroundColor(.primary)
//                    .frame(width: 40, alignment: .trailing)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//}
//
//// MARK: - Preview (Xcode Canvas)
//#Preview {
//    let mockItems: [NutritionalFactsItem] = [
//        NutritionalFactsItem(name: "Valor energético (kcal)", value100g: "150", valuePortion: "45", dailyValue: "2", isBold: true),
//        NutritionalFactsItem(name: "Carboidratos (g)", value100g: "20", valuePortion: "6", dailyValue: "2", isBold: true),
//        NutritionalFactsItem(name: "Açúcares totais (g)", value100g: "12", valuePortion: "3.6", dailyValue: "", isIndent: true),
//        NutritionalFactsItem(name: "Açúcares adicionados (g)", value100g: "10", valuePortion: "3", dailyValue: "6", isIndent: true),
//        NutritionalFactsItem(name: "Proteínas (g)", value100g: "5", valuePortion: "1.5", dailyValue: "3", isBold: true),
//        NutritionalFactsItem(name: "Gorduras totais (g)", value100g: "6", valuePortion: "1.8", dailyValue: "3", isBold: true),
//        NutritionalFactsItem(name: "Gorduras saturadas (g)", value100g: "2", valuePortion: "0.6", dailyValue: "3", isIndent: true),
//        NutritionalFactsItem(name: "Gorduras trans (g)", value100g: "0", valuePortion: "0", dailyValue: "0", isIndent: true),
//        NutritionalFactsItem(name: "Fibras alimentares (g)", value100g: "3", valuePortion: "0.9", dailyValue: "4", isBold: true),
//        NutritionalFactsItem(name: "Sódio (mg)", value100g: "100", valuePortion: "30", dailyValue: "2", isBold: true)
//    ]
//    
//    ScrollView {
//        NutritionFactsTable(items: mockItems, servingText: "30 g")
//            .padding()
//    }
//}

import SwiftUI

struct NutritionFactsTable: View {
    // Array de itens já formatados vindo do DTO
    let items: [NutritionalFactsItem]
    
    // MARK: - Informações de Porções (Anvisa)
    // Inicializados como nil por padrão para receber os dados dinâmicos do DTO
    var servingsPerContainer: String? = nil
    var servingSizeText: String? = nil
    var servingText: String = "Porção"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Cabeçalho da Tabela
            headerView
            
            // Exibe a seção de porções apenas se houver dados
            if servingsPerContainer != nil || servingSizeText != nil {
                Divider()
                    .background(Color.primary)
                
                VStack(alignment: .leading, spacing: 8) {
                    if let servings = servingsPerContainer {
                        Text("Porções por embalagem: \(servings)")
                            .font(.system(.subheadline))
                            .foregroundColor(.primary)
                    }
                    if let portion = servingSizeText {
                        Text("Porção: \(portion)")
                            .font(.system(.subheadline))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.vertical, 12)
            }
            
            Divider()
                .background(Color.primary)
            
            // Sub-cabeçalho da tabela (100g / Porção / %VD)
            subHeaderView
            
            Divider()
                .background(Color.primary)
            
            // MARK: - Linhas de Nutrientes
            ForEach(items) { item in
                rowView(for: item)
                
                Divider()
                    .opacity(0.9)
            }
            
            // Rodapé
            HStack {
                Text("* % Valores Diários com base em uma dieta de 2.000 kcal.")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
    
    // MARK: - Subviews
    private var headerView: some View {
        Text("Tabela Nutricional")
            .font(.system(.title, weight: .bold))
            .foregroundColor(Color("buttonColor"))
            .padding(.bottom, 12)
    }
    
    private var subHeaderView: some View {
        HStack {
            Spacer()
            
            HStack(spacing: 16) {
                Text("100 g")
                    .font(.system(.subheadline, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 50, alignment: .trailing)
                
                Text(servingText)
                    .font(.system(.subheadline, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 60, alignment: .trailing)
                
                Text("%VD*")
                    .font(.system(.subheadline, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 50, alignment: .trailing)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func rowView(for item: NutritionalFactsItem) -> some View {
        HStack {
            Text(item.name)
                .font(.system(.subheadline, weight: item.isBold ? .bold : .regular))
                .foregroundColor(.primary)
                .padding(.leading, item.isIndent ? 16 : 0)
            
            Spacer()
            
            HStack(spacing: 16) {
                Text(item.value100g)
                    .font(.system(.subheadline, weight: item.isBold ? .semibold : .regular))
                    .foregroundColor(.primary)
                    .frame(width: 50, alignment: .trailing)
                
                Text(item.valuePortion)
                    .font(.system(.subheadline, weight: item.isBold ? .semibold : .regular))
                    .foregroundColor(.primary)
                    .frame(width: 60, alignment: .trailing)
                
                Text(item.dailyValue.isEmpty ? "-" : "\(item.dailyValue)%")
                    .font(.system(.subheadline, weight: item.isBold ? .semibold : .regular))
                    .foregroundColor(.primary)
                    .frame(width: 50, alignment: .trailing)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let mockItems: [NutritionalFactsItem] = [
        NutritionalFactsItem(name: "Valor energético (kcal)", value100g: "250", valuePortion: "150", dailyValue: "8", isBold: true),
        NutritionalFactsItem(name: "Carboidratos (g)", value100g: "30", valuePortion: "18", dailyValue: "6", isBold: true),
        NutritionalFactsItem(name: "Açúcares totais (g)", value100g: "15", valuePortion: "9", dailyValue: "", isIndent: true),
        NutritionalFactsItem(name: "Açúcares adicionados (g)", value100g: "10", valuePortion: "6", dailyValue: "12", isIndent: true),
        NutritionalFactsItem(name: "Proteínas (g)", value100g: "8", valuePortion: "4.8", dailyValue: "10", isBold: true),
        NutritionalFactsItem(name: "Gorduras totais (g)", value100g: "11", valuePortion: "6.6", dailyValue: "12", isBold: true),
        NutritionalFactsItem(name: "Gorduras saturadas (g)", value100g: "4", valuePortion: "2.4", dailyValue: "12", isIndent: true),
        NutritionalFactsItem(name: "Gorduras trans (g)", value100g: "0", valuePortion: "0", dailyValue: "0", isIndent: true),
        NutritionalFactsItem(name: "Fibras alimentares (g)", value100g: "3", valuePortion: "1.8", dailyValue: "7", isBold: true),
        NutritionalFactsItem(name: "Sódio (mg)", value100g: "200", valuePortion: "120", dailyValue: "6", isBold: true)
    ]
    
    ScrollView {
        NutritionFactsTable(
            items: mockItems,
            servingsPerContainer: "12 porções",
            servingSizeText: "60 g (1 fatia)"
        )
        .padding()
    }
}
