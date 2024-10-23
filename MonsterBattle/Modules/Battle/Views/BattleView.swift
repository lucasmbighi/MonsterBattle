//
//  BattleView.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import SwiftUI

struct BattleView<ViewModel: BattleViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Battle of Monsters")
                .font(.roboto(size: 36))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Select your monster")
                .font(.roboto(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.monsters) { monster in
                        MonsterCardView(monster: monster)
                            .onTapGesture {
                                viewModel.choosePlayerMonster(monster)
                                viewModel.chooseCPUMonster()
                            }
                    }
                }
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    DetailedMonsterCardView(emptyLabel: "Player", monster: viewModel.playerMonster)
                    
                    DetailedMonsterCardView(emptyLabel: "Computer", monster: viewModel.cpuMonster)
                }
            }
            
            Button(action: {
                Task {
                    await viewModel.startBattle()
                }
            }, label: {
                if let battleResponse = viewModel.battleResponse {
                    Text("\(battleResponse.winner.name) wins!")
                        .font(.roboto(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(18)
                        .background(.green)
                } else {
                    Text("Start Battle")
                        .font(.roboto(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(18)
                        .background(.green)
                }
            })
            .disabled(viewModel.cpuMonster == nil)
        }
        .padding(20)
        .task {
            await viewModel.fetchMonsters()
        }
    }
}

#Preview {
    BattleView(viewModel: BattleViewModel())
}
