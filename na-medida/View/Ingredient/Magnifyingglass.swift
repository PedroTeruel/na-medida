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
            
            Group {
                if let imageURLString = imageURL, let url = URL(string: imageURLString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.primary)
                        .background(Color.gray.opacity(0.5))
                }
            }
            .frame(width: 175, height: 175)
            .clipShape(Circle())
            .offset(y: -20)
        }
    }
}

#Preview {
    Magnifyingglass(imageURL: nil)
}
