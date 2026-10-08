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
    
    private var isEmoji: Bool {
        guard let url = urlString, !url.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return !url.hasPrefix("http")
    }
    
    var body: some View {
        
        if isEmoji, let emoji = urlString {
            Text(emoji)
                .font(.system(size: size * 0.55))
                .frame(width: size, height: size)
                .background(Color.blue.gradient)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
        } else if let urlString = urlString, let url = URL(string: urlString) {
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
