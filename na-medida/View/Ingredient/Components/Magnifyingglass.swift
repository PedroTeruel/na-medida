//
//  Magnifyingglass.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 06/10/26.
//

import SwiftUI

struct Magnifyingglass: View {
    
    var imageURL: String?
    
    var body: some View {
        ZStack {
            Image("IconLupa")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
            
            AsyncProductImage(
                urlString: imageURL,
                size: 175,
                cornerRadius: 175 / 2
            )
            .offset(y: -20)
        }
    }
}

#Preview {
    Magnifyingglass(imageURL: nil)
}
