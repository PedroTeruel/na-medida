//
//  LegalSectionCard.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 20/10/26.
//

import SwiftUI

struct LegalSectionCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let section: LegalSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 14) {
                Image(systemName: section.icon)
                    .font(.title3)
                    .foregroundStyle(section.tintColor)
                    .frame(width: 46, height: 46)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(section.tintColor.opacity(0.12))
                    }
                
                Text("\(section.number). \(section.title)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 0)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 14) {
                ForEach(section.clauses) { clause in
                    VStack(alignment: .leading, spacing: 8) {
                        clauseText(for: clause)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if !clause.bullets.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(clause.bullets, id: \.self) { bullet in
                                    HStack(alignment: .top, spacing: 10) {
                                        Circle()
                                            .fill(section.tintColor)
                                            .frame(width: 6, height: 6)
                                            .padding(.top, 6)
                                        
                                        Text(bullet)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineSpacing(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                            .padding(.leading, 8)
                            .padding(.top, 2)
                        }
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(colorScheme == .dark ? Color(.secondarySystemBackground) : .white)
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.secondary.opacity(0.2), lineWidth: 1.5)
        }
    }
    
    private func clauseText(for clause: LegalClause) -> Text {
        let numberText = Text("\(clause.number) ")
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
        
        if let title = clause.title {
            let titleText = Text("\(title): ")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            return Text("\(numberText)\(titleText)\(clause.text)")
        } else {
            return Text("\(numberText)\(clause.text)")
        }
    }
}
