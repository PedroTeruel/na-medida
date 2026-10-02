//
//  AboutView.swift
//  na-medida
//
//  Created by Pedro Henrique Hossaka Teruel on 02/10/26.
//

import SwiftUI

struct AboutView: View {
    
//    @Environment(Router.self) private var router
    private var username = "William"
    
    var body: some View {
        VStack(spacing: 40){
            VStack{
                Text("""
                     Olá,
                     \(username)!
                     """)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.semibold)
                Button("Alterar nome") {
                    //router.navigate(to: .main(username: username))
                }
            }
            VStack(spacing: 20){
                Text("Sobre nutrientes")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    AboutView()
}
