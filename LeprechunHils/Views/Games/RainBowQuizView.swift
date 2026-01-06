//
//  RainBowQuizView.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI

struct RainBowQuizView: View {
    @StateObject private var viewModel = QuizViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.mainBack)
                .resizable()
                .ignoresSafeArea()
            
            if viewModel.shouldShowTopicSelection {
                topicSelectionView
            } else if viewModel.quizCompleted {
                resultsView
            } else {
                quizView
            }
        }
        //.navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(.quizLabel)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    private var topicSelectionView: some View {
        VStack(spacing: 20) {
            Image(.chooseQuizLabel)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            VStack(spacing: 15) {
                ForEach(QuizTopic.allCases, id: \.self) { topic in
                    Button {
                        viewModel.startQuiz(topic: topic)
                    } label: {
                        ZStack {
                            Image(.backButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Text(topic.rawValue)
                                .font(.largeTitle)
                                .monospaced()
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            
            Spacer()
        }.padding()
    }
    
    private var quizView: some View {
        VStack(spacing: 30) {
            // Progress indicator
            HStack {
                Text(viewModel.progressText)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text(viewModel.scoreText)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Question
            if let question = viewModel.currentQuestion {
                VStack(spacing: 25) {
                    QuestionView(text: question.question)
                    
                    VStack(spacing: 15) {
                        ForEach(0..<question.options.count, id: \.self) { index in
                            Button {
                                viewModel.selectAnswer(index)
                            } label: {
                                ZStack {
                                    
                                    Image(.backButton)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
 
                                    HStack {
                                        Text(viewModel.getAnswerLabel(for: index))
                                            .font(.title3)
                                            .bold()
                                            .foregroundColor(.black)
                                        
                                        Text(question.options[index])
                                            .font(.title3)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        if viewModel.shouldShowCheckmark(for: index) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                        } else if viewModel.shouldShowXmark(for: index) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                        }else{
                                            Image(systemName: "xmark.circle.fill")
                                                .opacity(0)
                                        }
                                    }
                                    .padding(.horizontal, 40)
                                }
                            }
                            .disabled(viewModel.showResult)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                        Button {
                            viewModel.nextQuestion()
                        } label: {
                            ZStack {
                                Image(.backButton)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                                Text(viewModel.nextButtonText)
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .disabled(!viewModel.showResult)
                    
                }
            }
            
            Spacer()
        }.padding()
    }
    
    private var resultsView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Quiz Completed!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            
            Text("Topic: \(viewModel.topicName)")
                .font(.title2)
                .foregroundColor(.black)
            
            VStack(spacing: 15) {
                Text("Your Score")
                    .font(.title3)
                    .foregroundColor(.black)
                
                Text(viewModel.scoreTextFormatted)
                    .font(.system(size: 50))
                    .bold()
                    .foregroundColor(.black)
                
                Text(viewModel.percentageText)
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
            )
            .padding(.horizontal, 40)
            
            Button {
                viewModel.resetQuiz()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.8))
                        .frame(height: 60)
                    
                    Text("Try Another Topic")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        RainBowQuizView()
    }
}
