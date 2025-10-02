//
//  StartRatingView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI

struct StartRatingView: View {
    
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { starRate in
                Button(action: {
                    rating = starRate
                }) {
                    Image(systemName: starRate <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.title2)
                }.buttonStyle(.plain)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityValue(Text("\(rating) out of 5 stars"))
        .accessibilityLabel("Book Rating")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                rating = min(rating + 1, 5)
            case .decrement:
                rating = max(rating - 1, 1)
            @unknown default:
                break
            }
        }
    }
}
