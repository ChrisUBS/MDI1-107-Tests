//
//  Genre.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 23/09/25.
//

import Foundation

enum Genre: String, CaseIterable, Identifiable, Hashable, Codable {
    case unkowned = "Unkowned"
    case classic = "Classic"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case romance = "Romance"
    case horror = "Horror"
    
    var id: Self { self } // for Identifiable conformance
    var displayName: String {
        rawValue.capitalized
    }
}
