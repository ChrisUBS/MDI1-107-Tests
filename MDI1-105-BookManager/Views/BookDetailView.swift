//
//  BookDetailView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI

struct BookDetailView: View {
    @Bindable var book: PersistentBook
    @State private var showingEdit = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(alignment: .top, spacing: 16) {
                    Image(
                        uiImage: book.imageData != nil
                        ? UIImage(data: book.imageData!)!
                        : UIImage()
                    )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.title ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("by \(book.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(book.summary ?? "")
                            .font(.body)
                            .padding(.top, 4)
                    }
                    Spacer()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Review")
                        .font(.headline)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Text(book.review ?? "")
                        .font(.body)
                        .padding(.top, 4)
                }
                
                HStack {
                    if (book.genre != .unkowned) {
                        CustomCapsule(text: book.genre.rawValue)
                    }
                    CustomCapsule(text: book.status.rawValue, color: Color.secondary)
                    Spacer()
                    FavoriteToggle(isFavorite: $book.isFavorite)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEdit = true
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            AddEditBookView(book: book) { _ in }
        }
    }
}

