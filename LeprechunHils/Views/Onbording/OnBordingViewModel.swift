//
//  OnBordingViewModel.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import Foundation
import Combine
import SwiftUI

final class OnBordingViewModel: ObservableObject {
    @AppStorage("ShowOnBording") var showOnBording: Bool = true
    
    @Published var selectedPage: Int = 0
    @Published var showMainScreen: Bool = false
    @Published var currentPage: OnbordingPage

    
    private let pages: [OnbordingPage] = [
        OnbordingPage(title: "Your English Guide",text: "Meet the leprechaun who helps you learn English with words, games, and stories.", image: .lepricon1),
        OnbordingPage(title: "Learn & Play", text: "Discover new words, match cards, and take colorful quizzes while earning clovers.", image: .lepricon2),
        OnbordingPage(title: "Stories & Rewards", text: "Read simple English stories, complete tasks, and collect clovers along the way.", image: .lepricon3)
    ]

    init(){
        currentPage = pages[0]
    }
    
    func nextPage() {
        if selectedPage == pages.count - 1 {
            showMain()
        }else{
            selectedPage += 1
            currentPage = pages[selectedPage]
        }
    }
    
    private func showMain() {
        showMainScreen.toggle()
        showOnBording = false
    }
}

struct OnbordingPage: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let image: ImageResource
}
