//
//  CarouselView.swift
//  na-medida
//
//  Created by Vitor Silva Souza on 05/10/26.
//

import SwiftUI

struct CarouselItem: Identifiable, Hashable {
    let id = UUID()
    let originalId: Int
    let imageName: String
    let value: String
}

struct CarouselView: View {
    @State private var scrollPosition: UUID?
    @State private var activeIndex: Int = 3
    @State private var items: [CarouselItem] = []
    
    let recipe: Recipe
    var baseData: [(Int, String, String)] {
        [
            (1, "CarouselSodio", AnvisaNutritionFormatter.format(recipe.totalRecipeSodium, scale: .mg)),
            (2, "CarouselProteinas", AnvisaNutritionFormatter.format(recipe.totalRecipeProteins, scale: .g)),
            (3, "CarouselCalorias", AnvisaNutritionFormatter.format(recipe.totalRecipeCalories, scale: .kcal)),
            (4, "CarouselCarbo", AnvisaNutritionFormatter.format(recipe.totalRecipeCarbs, scale: .g)),
            (5, "CarouselGorduras", AnvisaNutritionFormatter.format(recipe.totalRecipeFats, scale: .g))
        ]
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let spacing: CGFloat = 24
            let cardWidth = (screenWidth / 2) - spacing
            let cardHeight = cardWidth * 1.28
            let horizontalPadding = (screenWidth - cardWidth) / 2
            
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: spacing) {
                        ForEach(items) { item in
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: cardWidth, height: cardHeight)
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                .shadow(color: .black.opacity(0.30), radius: 2, x: 0, y: 1)
                                .overlay {
                                    Text(item.value)
                                        .font(.custom("Atma-Bold", size: 28))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                        .padding(.top, cardHeight * 0.25)
                                }
                                .id(item.id)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.50)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, horizontalPadding)
                .scrollPosition(id: $scrollPosition)
                .onChange(of: scrollPosition) { _, newValue in
                    if let newValue, let currentItem = items.first(where: { $0.id == newValue }) {
                        activeIndex = currentItem.originalId
                    }
                }
                .onAppear {
                    setupInfiniteCarousel()
                }
                .onChange(of: recipe.ingredients.count) { _, _ in
                    setupInfiniteCarousel()
                }
                
                HStack(spacing: 12) {
                    ForEach(baseData, id: \.0) { data in
                        Circle()
                            .fill(activeIndex == data.0 ? Color.primary : Color.secondary.opacity(0.6))
                            .frame(width: 8, height: 8)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: activeIndex)
                    }
                }
            }
        }
        .frame(height: 260)
        .background {
            Image(recipe.tag?.carouselImageBaseName ?? "WaveDefault")
                .resizable()
                .scaledToFill()
        }
        .clipped()
    }
    
    private func setupInfiniteCarousel() {
        let numberOfRepeats = 100
        var newItems: [CarouselItem] = []
        
        for _ in 0..<numberOfRepeats {
            for data in baseData {
                newItems.append(CarouselItem(originalId: data.0, imageName: data.1, value: data.2))
            }
        }
        items = newItems
        
        let middleChunkIndex = numberOfRepeats / 2
        let startIndex = (middleChunkIndex * baseData.count) + (activeIndex - 1)
        
        DispatchQueue.main.async {
            scrollPosition = newItems[startIndex].id
        }
    }
}
