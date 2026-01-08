//
//  AwardsManager.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import Foundation
import Combine

class AwardsManager: ObservableObject {
    static let shared = AwardsManager()
    
    @Published var earnedAwards: Set<Awards> = []
    
    private let userDefaultsKey = "earnedAwards"
    
    private init() {
        loadAwards()
    }
    
    func isAwardEarned(_ award: Awards) -> Bool {
        earnedAwards.contains(award)
    }
    
    func earnAward(_ award: Awards) {
        guard !earnedAwards.contains(award) else { return }
        earnedAwards.insert(award)
        saveAwards()
    }
    
    func earnAwards(_ awards: [Awards]) {
        var newAwards: [Awards] = []
        for award in awards {
            if !earnedAwards.contains(award) {
                earnedAwards.insert(award)
                newAwards.append(award)
            }
        }
        if !newAwards.isEmpty {
            saveAwards()
        }
    }
    
    private func loadAwards() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let awards = try? JSONDecoder().decode([String].self, from: data) {
            earnedAwards = Set(awards.compactMap { Awards(rawValue: $0) })
        }
    }
    
    private func saveAwards() {
        let awardsStrings = Array(earnedAwards.map { $0.rawValue })
        if let data = try? JSONEncoder().encode(awardsStrings) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    func resetAwards() {
        earnedAwards.removeAll()
        saveAwards()
    }
}

