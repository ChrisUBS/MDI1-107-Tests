//
//  ReadingStatus.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 23/09/25.
//

import Foundation

enum ReadingStatus: String, CaseIterable, Identifiable, Hashable, Codable {
    case planned = "Planned"
    case reading = "Reading"
    case dropped = "Dropped"
    case finished = "Finished"
    
    var id: Self { self }
    var displayName: String {
        rawValue.capitalized
    }
}
