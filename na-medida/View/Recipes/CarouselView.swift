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
    
    let baseData = [
        (1, "CarouselSodio", "9999"),
        (2, "CarouselProteinas", "2000"),
        (3, "CarouselCalorias", "150"),
        (4, "CarouselCarbo", "220"),
        (5, "CarouselGorduras", "65")
    ]
    
    @State private var items: [CarouselItem] = []
    
    var body: some View {
            
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(items) { item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 270)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: -1)
                            .overlay {
                                Text(item.value)
                                    .font(.custom("Atma-Bold", size: 36))
                                    .foregroundColor(.white)
                                    .padding(.top, 76)
                            }
                            .containerRelativeFrame(.horizontal)
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
            .safeAreaPadding(.horizontal, 100)
            .scrollPosition(id: $scrollPosition)
            .onChange(of: scrollPosition) { _, newValue in
                if let newValue, let currentItem = items.first(where: { $0.id == newValue }) {
                    activeIndex = currentItem.originalId
                }
            }
            .onAppear {
                setupInfiniteCarousel()
            }
            
            HStack(spacing: 8) {
                ForEach(baseData, id: \.0) { data in
                    Circle()
                        .fill(activeIndex == data.0 ? Color.primary : Color.secondary.opacity(0.6))
                        .frame(width: 8, height: 8)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: activeIndex)
                }
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ZStack {
                Image("FundoCarouselRed")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(activeIndex % 2 != 0 ? 1.0 : 0.0)
                
                Image("FundoCarouselRed190")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(activeIndex % 2 == 0 ? 1.0 : 0.0)
            }
            .animation(.easeInOut(duration: 0.6), value: activeIndex)
        }
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

#Preview {
    CarouselView()
}
