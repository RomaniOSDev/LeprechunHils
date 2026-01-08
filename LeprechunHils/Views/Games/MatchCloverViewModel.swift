//
//  MatchCloverViewModel.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI
import Combine

struct MatchCard {
    let imageName: String
    let correctAnswer: String // English word
}

class MatchCloverViewModel: ObservableObject {
    @Published var selectedCardCount: Int?
    @Published var currentCardIndex = 0
    @Published var userAnswer = ""
    @Published var gameCompleted = false
    @Published var newAward: Awards? = nil
    
    private let awardsManager = AwardsManager.shared
    private var correctAnswersCount = 0
    
    let availableCardCounts = [4, 6, 8, 12, 16]
    
    private let allCards: [MatchCard] = [
        MatchCard(imageName: "flower", correctAnswer: "flower"),
        MatchCard(imageName: "rose", correctAnswer: "rose"),
        MatchCard(imageName: "honey", correctAnswer: "honey"),
        MatchCard(imageName: "clover", correctAnswer: "clover"),
        MatchCard(imageName: "tree", correctAnswer: "tree"),
        MatchCard(imageName: "mushroom", correctAnswer: "mushroom"),
        MatchCard(imageName: "sun", correctAnswer: "sun"),
        MatchCard(imageName: "fox", correctAnswer: "fox"),
        MatchCard(imageName: "rabbit", correctAnswer: "rabbit"),
        MatchCard(imageName: "squirrel", correctAnswer: "squirrel"),
        MatchCard(imageName: "bird", correctAnswer: "bird"),
        MatchCard(imageName: "leaf", correctAnswer: "leaf"),
        MatchCard(imageName: "hat", correctAnswer: "hat"),
        MatchCard(imageName: "apple", correctAnswer: "apple"),
        MatchCard(imageName: "banana", correctAnswer: "banana"),
        MatchCard(imageName: "monkey", correctAnswer: "monkey")
    ]
    
    var selectedCards: [MatchCard] = []
    
    // MARK: - Computed Properties
    
    var shouldShowCardCountSelection: Bool {
        selectedCardCount == nil
    }
    
    var currentCard: MatchCard? {
        guard currentCardIndex < selectedCards.count else { return nil }
        return selectedCards[currentCardIndex]
    }
    
    var progressText: String {
        guard let cardCount = selectedCardCount else { return "" }
        return "Card \(currentCardIndex + 1) of \(cardCount)"
    }
    
    var canGoNext: Bool {
        guard let cardCount = selectedCardCount else { return false }
        return currentCardIndex < cardCount - 1
    }
    
    var nextButtonText: String {
        canGoNext ? "Next Card" : "Finish"
    }
    
    // MARK: - Methods
    
    func startGame(with cardCount: Int) {
        selectedCardCount = cardCount
        selectedCards = Array(allCards.shuffled().prefix(cardCount))
        currentCardIndex = 0
        userAnswer = ""
        gameCompleted = false
        correctAnswersCount = 0
    }
    
    func nextCard() {
        // Check if current answer is correct before moving
        if isAnswerCorrect() {
            correctAnswersCount += 1
        }
        
        if canGoNext {
            currentCardIndex += 1
            userAnswer = ""
        } else {
            gameCompleted = true
            checkAwards()
        }
    }
    
    func checkAwards() {
        guard let cardCount = selectedCardCount else { return }
        
        var earnedAwards: [Awards] = []
        
        // First Clover - первая награда
        if !awardsManager.isAwardEarned(.first) {
            earnedAwards.append(.first)
        }
        
        // Memory Master - за прохождение игры
        if !awardsManager.isAwardEarned(.memory) {
            earnedAwards.append(.memory)
        }
        
        // Perfect Match - за идеальное прохождение (все ответы правильные)
        if correctAnswersCount == cardCount && !awardsManager.isAwardEarned(.perfect) {
            earnedAwards.append(.perfect)
        }
        
        // Earn awards
        if !earnedAwards.isEmpty {
            awardsManager.earnAwards(earnedAwards)
            newAward = earnedAwards.first
        }
    }
    
    func resetGame() {
        selectedCardCount = nil
        currentCardIndex = 0
        userAnswer = ""
        selectedCards = []
        gameCompleted = false
    }
    
    func isAnswerCorrect() -> Bool {
        guard let card = currentCard else { return false }
        return userAnswer.lowercased().trimmingCharacters(in: .whitespaces) == card.correctAnswer.lowercased()
    }
}

