//
//  PersistentBook.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 27/09/25.
//

import Foundation
import SwiftData

@Model
class PersistentBook {
    var title: String
    var imageData: Data?
    var summary: String
    var author: String
    var year: Int? = nil
    var category: String
    var rating: Int
    var review: String
    var status: ReadingStatus
    var genre: Genre
    var isFavorite: Bool
    
    init(title: String = "",
         imageData: Data? = nil,
         summary: String = "",
         author: String = "",
         year: Int? = nil,
         category: String = "",
         rating: Int = 0,
         review: String = "",
         status: ReadingStatus = .planned,
         genre: Genre = .unkowned,
         isFavorite: Bool = false) {
        
        self.title = title
        self.imageData = imageData
        self.summary = summary
        self.author = author
        self.year = year
        self.category = category
        self.rating = rating
        self.review = review
        self.status = status
        self.genre = genre
        self.isFavorite = isFavorite
    }
}
