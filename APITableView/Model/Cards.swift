//
//  Cards.swift
//  APITableView
//
//  Created by Мария Вольвакова on 05.08.2022.
//

import UIKit


struct Cards: Decodable {
  let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let setName: String?
    let imageUrl: String?
    let manaCost: String?
    let cmc: Int?
    let type: String?
    let rarity: String?
    let text: String?
    let artist: String?
}
