//
//  MonsterCardView.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import SwiftUI

struct MonsterCardView: View {
    
    let monster: Monster
    
    var body: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(.white.shadow(.drop(radius: 5)))
            .overlay {
                VStack {
                    AsyncImage(url: URL(string: monster.imageUrl)) { image in
                        image
                            .resizable()
                            .frame(width: 136, height: 99)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 136, height: 99)
                    }

                    Text(monster.name)
                        .font(.roboto(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(7)
            }
            .frame(width: 150, height: 139)
    }
}

#Preview {
    let monster = Monster(id: "1", name: "Dead Unicorn", attack: 10, defense: 10, hp: 10, speed: 10, type: "", imageUrl: "")
    return MonsterCardView(monster: monster)
}
