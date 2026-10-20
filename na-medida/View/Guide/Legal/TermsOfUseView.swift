//
//  TermsOfUseView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 05/10/26.
//

import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Leia com atenção as condições de uso, privacidade e responsabilidades do aplicativo Na Medida.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                MeasureWarningCard(
                    cardTitle: "Privacidade e Armazenamento Local",
                    cardBody: "Suas receitas ficam salvas apenas no seu próprio dispositivo.\nVigência a partir de 14 de outubro de 2026."
                )
                
                VStack(spacing: 16) {
                    ForEach(LegalData.termsOfUseSections) { section in
                        LegalSectionCard(section: section)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("Termos de Uso")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        TermsOfUseView()
    }
}
