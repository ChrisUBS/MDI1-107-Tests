//
//  api.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import Foundation

func getBooks() -> [Book] {
    return [ // Hardcoded
        Book(title: "The Fellowship of The Ring", description: "The first book in the trilogy", author: "J.R.R. Tolkien", year: 1954, category: "Adventure/Fantasy", rating: 4, review: "Tolkien’s world-building shines in this opening volume. The Shire feels cozy and familiar, yet the journey quickly expands into an epic full of danger and wonder. The formation of the Fellowship is handled beautifully, and the Mines of Moria remain one of the most thrilling sequences in fantasy literature. At times, the pacing is slow, but the sense of myth and history makes every page feel weighty.", status: ReadingStatus.reading),
        Book(title: "The Two Towers", description: "The second book in the trilogy", author: "J.R.R. Tolkien", year: 1954, category: "Adventure/Fantasy", rating: 4, review: "The second book splits the narrative into parallel threads, which creates both tension and breadth. Rohan’s struggles and the Battle of Helm’s Deep provide some of the most cinematic moments in the trilogy. Meanwhile, Frodo and Sam’s trek with Gollum adds layers of moral ambiguity and emotional weight. It’s darker than the first book, but that depth is what makes it so powerful.", status: ReadingStatus.reading),
        Book(title: "The Return of The King", description: "The third and last book in the trilogy", author: "J.R.R. Tolkien", year: 1955, category: "Adventure/Fantasy", rating: 5, review: "The conclusion is sweeping, dramatic, and deeply satisfying. The battles for Gondor and the march on Mordor are breathtaking in scale, but Tolkien balances the spectacle with moments of quiet humanity. Frodo’s final burden and the bittersweet ending in the Shire give the story emotional resonance beyond the typical “good triumphs over evil” arc. A masterful ending to a legendary saga.", status: ReadingStatus.reading, isFavorite: true),
        Book(title: "Test", description: "Test", author: "Test", year: 2000, category: "Action", rating: 4, review: "Test", status: ReadingStatus.reading, isFavorite: true)
    ]
}
