//
//  AsyncProductImage.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 04/10/26.
//

import SwiftUI

struct AsyncProductImage: View {
    let urlString: String?
    let size: CGFloat
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    fallbackImage
                case .empty:
                    ProgressView()
                @unknown default:
                    fallbackImage
                }
            }
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            fallbackImage
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
    
    private var fallbackImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .padding(size * 0.25)
            .background(Color.gray.opacity(0.2))
            .foregroundStyle(.gray)
    }
}
