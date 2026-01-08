//
//  AwardsView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct AwardsView: View {
    @ObservedObject private var awardsManager = AwardsManager.shared
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(Awards.allCases, id: \.self) { award in
                        AwardSimpleView(
                            award: award,
                            isEarned: awardsManager.isAwardEarned(award)
                        )
                        .padding(8)
                    }
                }
            }.padding(.horizontal)
        }
    }
}

#Preview {
    AwardsView()
}

enum Awards: String, CaseIterable, Identifiable, Codable {
    case first = "first"
    case word = "word"
    case rainbow = "rainbow"
    case memory = "memory"
    case perfect = "perfect"
    case listener = "listener"
    case lover = "lover"
    case chmpionQuiz = "chmpionQuiz"
    case animal = "animal"
    case food = "food"
    case flower = "flower"
    case story = "story"
    
    var id: String { rawValue }
    
    var image: ImageResource{
        switch self {
            
        case .first:
            return .first
        case .word:
            return .word
        case .rainbow:
            return .rainbow
        case .memory:
            return .memory
        case .perfect:
            return .perfect
        case .listener:
            return .listener
        case .lover:
            return .lover
        case .chmpionQuiz:
            return .chmpionQuiz
        case .animal:
            return .animal
        case .food:
            return .food
        case .flower:
            return .flower
        case .story:
            return .story
        }
    }
    
    var title: String {
        switch self {
        
        case .first:
            return "First Clover"
        case .word:
            return "Word Explorer"
        case .rainbow:
            return "Rainbow Starter"
        case .memory:
            return "Memory Master"
        case .perfect:
            return "Perfect Match"
        case .listener:
            return "Story Listener"
        case .lover:
            return "Story Lover"
        case .chmpionQuiz:
            return "Quiz Champion"
        case .animal:
            return "Animal Friend"
        case .food:
            return "Food Lover"
        case .flower:
            return "flowers Lover"
        case .story:
            return "Story Explorer"
        }
    }
}
