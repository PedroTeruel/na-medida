//
//  PrivacyPolicyView.swift
//  na-medida
//
//  Created by Rebeca Emanuela Calmon de Andrade Alves on 16/10/26.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Saiba como tratamos suas informações e protegemos sua privacidade no aplicativo Na Medida.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                MeasureWarningCard(
                    cardTitle: "Privacidade e Transparência",
                    cardBody: "Seus dados e receitas ficam armazenados exclusivamente no seu dispositivo.\nVigência a partir de 16 de outubro de 2026."
                )
                
                VStack(spacing: 16) {
                    ForEach(LegalData.privacyPolicySections) { section in
                        LegalSectionCard(section: section)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .navigationTitle("Política de Privacidade")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
