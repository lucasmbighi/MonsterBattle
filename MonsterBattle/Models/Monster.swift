//
//  Monster.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import Foundation

struct Monster: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let attack: Int
    let defense: Int
    let hp: Int
    let speed: Int
    let type: String
    let imageUrl: String
}
