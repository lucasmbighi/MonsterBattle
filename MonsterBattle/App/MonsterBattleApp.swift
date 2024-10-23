//
//  MonsterBattleApp.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import SwiftUI

@main
struct MonsterBattleApp: App {
    var body: some Scene {
        WindowGroup {
            BattleView(viewModel: BattleViewModel())
        }
    }
}
