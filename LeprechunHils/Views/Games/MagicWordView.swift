//
//  MagicWordView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct MagicWordView: View {
    @StateObject private var viewModel = MagicWordViewModel()
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Progress indicator
                Text(viewModel.progressText)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                Spacer()
                
                // Word and description
                VStack(spacing: 25) {
                    // Word
                    ZStack {
                        Image(.backButton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                        
                        Text(viewModel.currentWord.word)
                            .font(.system(size: 40, weight: .bold))
                            .monospaced()
                            .foregroundColor(.black)
                    }
                    
                    // Description
                    ZStack {
                        Image(.backButton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                        
                        Text(viewModel.currentWord.description)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Navigation buttons
                HStack(spacing: 20) {
                    // Previous button
                    Button {
                        viewModel.previousWord()
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                            
                            Text("Previous")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .disabled(!viewModel.canGoPrevious)
                    .opacity(viewModel.canGoPrevious ? 1.0 : 0.5)
                    
                    // Next button
                    Button {
                        viewModel.nextWord()
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                            
                            Text("Next")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .disabled(!viewModel.canGoNext)
                    .opacity(viewModel.canGoNext ? 1.0 : 0.5)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .padding()
        }
        
    }
}

#Preview {
    NavigationStack {
        MagicWordView()
    }
}
