//
//  BattleViewModel.swift
//  MonsterBattle
//
//  Created by Lucas Bighi on 22/10/24.
//

import Foundation

enum BattleViewState {
    case ready, loading, error(Error)
}

protocol BattleViewModelProtocol: ObservableObject {
    var viewState: BattleViewState { get set }
    var monsters: [Monster] { get set }
    var playerMonster: Monster? { get set }
    var cpuMonster: Monster? { get set }
    var battleResponse: BattleResponse? { get set }
    
    func fetchMonsters() async
    func choosePlayerMonster(_ monster: Monster)
    func chooseCPUMonster()
    func startBattle() async
}

final class BattleViewModel: BattleViewModelProtocol {
    
    enum NetworkError: Error {
        case urlError
    }
    
    @Published var viewState: BattleViewState = .ready
    @Published var monsters: [Monster] = []
    @Published var playerMonster: Monster?
    @Published var cpuMonster: Monster?
    @Published var battleResponse: BattleResponse?
    
    func fetchMonsters() async {
        viewState = .loading
        guard let url = URL(string: "http://localhost:8090/monsters") else {
            viewState = .error(NetworkError.urlError)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let monsters = try JSONDecoder().decode([Monster].self, from: data)
            self.monsters = monsters
            viewState = .ready
        } catch {
            viewState = .error(error)
        }
    }
    
    func choosePlayerMonster(_ monster: Monster) {
        playerMonster = monster
    }
    
    func chooseCPUMonster() {
        let filteredMonsters = monsters.filter { $0 != playerMonster }
        cpuMonster = filteredMonsters.randomElement()
    }
    
    func startBattle() async {
        viewState = .loading
        guard let url = URL(string: "http://localhost:8090/battle") else {
            viewState = .error(NetworkError.urlError)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let battleRequest = BattleRequest(monster1Id: playerMonster?.id ?? "", monster2Id: cpuMonster?.id ?? "")
        request.httpBody = try? JSONEncoder().encode(battleRequest)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let battleResponse = try JSONDecoder().decode(BattleResponse.self, from: data)
            self.battleResponse = battleResponse
            viewState = .ready
        } catch {
            viewState = .error(error)
        }
    }
}
