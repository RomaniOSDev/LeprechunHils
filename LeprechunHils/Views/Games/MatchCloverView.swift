//
//  MatchCloverView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct MatchCloverView: View {
    @StateObject private var viewModel = MatchCloverViewModel()
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            if viewModel.shouldShowCardCountSelection {
                cardCountSelectionView
            } else if viewModel.gameCompleted {
                gameCompletedView
            } else {
                gameView
            }
        }
    }
    
    private var cardCountSelectionView: some View {
        VStack(spacing: 20) {
            Image(.selectMatchLabel)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            VStack(spacing: 15) {
                ForEach(viewModel.availableCardCounts, id: \.self) { count in
                    Button {
                        viewModel.startGame(with: count)
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                            
                            Text("\(count) Cards")
                                .font(.title2)
                                .monospaced()
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
    
    private var gameView: some View {
        VStack(spacing: 30) {
            // Progress indicator
            Text(viewModel.progressText)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Spacer()
            
            if let card = viewModel.currentCard {
                VStack(spacing: 25) {
                    // Image
                    ZStack {
                        Image(.backToOnboardText)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(card.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(100)
                    }
                    
                    // Text input field
                    ZStack {
                        Image(.backAnswerMathc)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        TextField("Enter the word", text: $viewModel.userAnswer)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal, 20)
                    
                    // Next button
                    Button {
                        viewModel.nextCard()
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                            
                            Text(viewModel.nextButtonText)
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .disabled(viewModel.userAnswer.trimmingCharacters(in: .whitespaces).isEmpty)
                    .opacity(viewModel.userAnswer.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1.0)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private var gameCompletedView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Game Completed!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            
            Text("Great job!")
                .font(.title2)
                .foregroundColor(.black)
            
            Button {
                viewModel.resetGame()
            } label: {
                ZStack {
                    Image(.backButton)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                    
                    Text("Play Again")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
        .sheet(item: $viewModel.newAward) { award in
            AwardModalView(award: award, isPresented: Binding(
                get: { viewModel.newAward != nil },
                set: { if !$0 { viewModel.newAward = nil } }
            ))
        }
    }
}

#Preview {
    NavigationStack {
        MatchCloverView()
    }
}
