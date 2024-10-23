//
//  DetailedMonsterCardView.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import SwiftUI

struct DetailedMonsterCardView: View {
    
    let emptyLabel: String
    let monster: Monster?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(.white.shadow(.drop(radius: 5)))
            .overlay {
                if let monster {
                    monsterView(monster)
                } else {
                    emptyView
                }
            }
            .frame(width: 255, height: 350)
    }
    
    private var emptyView: some View {
        Text(emptyLabel)
            .font(.roboto(size: 36))
    }
    
    private func monsterView(_ monster: Monster) -> some View {
        VStack {
            AsyncImage(url: URL(string: monster.imageUrl)) { image in
                image
                    .resizable()
                    .frame(width: 235, height: 148)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            } placeholder: {
                ProgressView()
                    .frame(width: 235, height: 148)
            }

            Text(monster.name)
                .font(.roboto(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            progressBar("HP", property: \.hp)
            progressBar("Attack", property: \.hp)
            progressBar("Defense", property: \.hp)
            progressBar("Speed", property: \.hp)
        }
        .padding(7)
    }
    
    private func progressBar(_ title: String, property: KeyPath<Monster, Int>) -> some View {
        VStack {
            Text(title)
                .font(.roboto(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ProgressView(value: CGFloat(monster?[keyPath: property] ?? 0), total: 100)
                .tint(.green)
        }
    }
}

#Preview {
    let monster = Monster(id: "1", name: "Dead Unicorn", attack: 10, defense: 10, hp: 10, speed: 10, type: "", imageUrl: "")
    return DetailedMonsterCardView(emptyLabel: "Player", monster: monster)
}
