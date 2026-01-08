//
//  MagicWordViewModel.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI
import Combine

struct MagicWord {
    let word: String
    let description: String
}

class MagicWordViewModel: ObservableObject {
    @Published var currentWordIndex = 0
    @Published var newAward: Awards? = nil
    
    private let awardsManager = AwardsManager.shared
    
    let words: [MagicWord] = [
        MagicWord(word: "Adventure", description: "An exciting or dangerous experience. Going on a trip to explore new places is an adventure."),
        MagicWord(word: "Beautiful", description: "Very pleasing to look at. A rainbow after rain is beautiful."),
        MagicWord(word: "Courage", description: "The ability to do something that frightens you. It takes courage to try something new."),
        MagicWord(word: "Discover", description: "To find something new or learn about something. Scientists discover new things every day."),
        MagicWord(word: "Enormous", description: "Very large in size. An elephant is an enormous animal."),
        MagicWord(word: "Fantastic", description: "Extraordinarily good or attractive. The magic show was fantastic!"),
        MagicWord(word: "Grateful", description: "Feeling or showing thanks. I am grateful for my friends."),
        MagicWord(word: "Harmony", description: "A pleasing arrangement of parts. The birds sang in harmony."),
        MagicWord(word: "Imagine", description: "To form a mental picture of something. Can you imagine flying like a bird?"),
        MagicWord(word: "Journey", description: "An act of traveling from one place to another. Our journey to the mountains was fun."),
        MagicWord(word: "Kindness", description: "The quality of being friendly and considerate. Showing kindness makes others happy."),
        MagicWord(word: "Luminous", description: "Full of or shedding light. The moon is luminous in the night sky."),
        MagicWord(word: "Magnificent", description: "Extremely beautiful and impressive. The castle was magnificent."),
        MagicWord(word: "Nature", description: "The natural world including plants, animals, and landscapes. We should protect nature."),
        MagicWord(word: "Optimistic", description: "Hopeful and confident about the future. An optimistic person sees the good in everything."),
        MagicWord(word: "Peaceful", description: "Free from disturbance. The garden was peaceful and quiet."),
        MagicWord(word: "Quiet", description: "Making little or no noise. The library is a quiet place."),
        MagicWord(word: "Respect", description: "A feeling of deep admiration. We should show respect to our elders."),
        MagicWord(word: "Serene", description: "Calm, peaceful, and untroubled. The lake looked serene in the morning."),
        MagicWord(word: "Triumph", description: "A great victory or achievement. Winning the race was a triumph.")
    ]
    
    // MARK: - Computed Properties
    
    var currentWord: MagicWord {
        words[currentWordIndex]
    }
    
    var progressText: String {
        "Word \(currentWordIndex + 1) of \(words.count)"
    }
    
    var canGoPrevious: Bool {
        currentWordIndex > 0
    }
    
    var canGoNext: Bool {
        currentWordIndex < words.count - 1
    }
    
    // MARK: - Methods
    
    func nextWord() {
        if canGoNext {
            currentWordIndex += 1
            checkAwards()
        }
    }
    
    func previousWord() {
        if canGoPrevious {
            currentWordIndex -= 1
        }
    }
    
    func checkAwards() {
        // First Clover - первая награда за любое действие
        if !awardsManager.isAwardEarned(.first) {
            awardsManager.earnAward(.first)
            newAward = .first
            return
        }
        
        // Word Explorer - за изучение всех слов (достижение последнего слова)
        if currentWordIndex == words.count - 1 && !awardsManager.isAwardEarned(.word) {
            awardsManager.earnAward(.word)
            newAward = .word
        }
    }
}


