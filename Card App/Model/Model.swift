//
//  Model.swift
//  Card App
//
//  Created by Sasha on 30.12.24.
//

import Foundation


struct Card {

    var title: String
    var photo: String

    static func addCard() -> [Card] {

        var cards: [Card] = []
        let data = DataStore.shared
        let photo = data.photos
        let title = data.photos

        let iteration = min(photo.count, title.count)

        for index in 0..<iteration {
            let photoCard = Card(
                title: photo[index],
                photo: photo[index]
            )

            cards.append(photoCard)
        }

        return cards
    }
}

