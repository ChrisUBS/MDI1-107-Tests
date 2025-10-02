//
//  FavoriteToggle.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 20/09/25.
//

import SwiftUI

struct FavoriteToggle: View {
    
    @Binding var isFavorite: Bool
    
    // Animation Variables
    @State private var scale: CGFloat = 1
    @State private var opacity: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
                .opacity(opacity)
                .scaleEffect(scale)
                .offset(y: offsetY)
            Toggle(isOn: $isFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .secondary)
            }
            .toggleStyle(.button)
            .buttonStyle(.plain)
            .animation(.spring, value: isFavorite)
            .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
            .onChange(of: isFavorite) { oldValue, newValue in
                guard newValue == true else {
                    // if there is an error or false in guard to this instead
                    return
                }
                // if guard is true it continues to here
                
                // Appear and grow
                withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                    // 0.1s => 0.2 opacity
                    // 0.2s => 0.4 opacity
                    // 0.3s => 0.6 opacity
                    // 0.4s => 0.8 opacity
                    // 0.5s => 1.0 opacity
                    opacity = 1 // makes the heart completely visible
                    scale = 1.2 // increase scale to %120
                }
                
                // Floating and Vanish
                withAnimation(.easeInOut(duration: 0.5).delay(0.3)) {
                    opacity = 0
                    offsetY = -100
                }
                
                // Let's wait for the animation to finish or do this after 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    scale = 1
                    offsetY = 0
                }
            }
        }
    }
}
