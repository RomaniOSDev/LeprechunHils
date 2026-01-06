//
//  QuizViewModel.swift
//  LeprechunHils
//
//  Created by Роман Главацкий on 06.01.2026.
//

import SwiftUI
import Combine

enum QuizTopic: String, CaseIterable {
    case colors = "Colors"
    case food = "Food"
    case cloth = "Cloth"
    case animals = "Animals"
    case flowers = "Flowers"
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int // Index of correct answer (0-2)
}

class QuizViewModel: ObservableObject {
    @Published var selectedTopic: QuizTopic?
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var selectedAnswer: Int?
    @Published var showResult = false
    @Published var quizCompleted = false
    
    var questions: [QuizQuestion] = []
    
    // MARK: - Computed Properties
    
    var currentQuestion: QuizQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progressText: String {
        "Question \(currentQuestionIndex + 1) of \(questions.count)"
    }
    
    var scoreText: String {
        "Score: \(score)"
    }
    
    var nextButtonText: String {
        currentQuestionIndex < questions.count - 1 ? "Next Question" : "Finish Quiz"
    }
    
    var topicName: String {
        selectedTopic?.rawValue ?? ""
    }
    
    var scorePercentage: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(score) / Double(questions.count) * 100
    }
    
    var scoreTextFormatted: String {
        "\(score) / \(questions.count)"
    }
    
    var percentageText: String {
        String(format: "%.0f%%", scorePercentage)
    }
    
    var shouldShowTopicSelection: Bool {
        selectedTopic == nil
    }
    
    var canGoBack: Bool {
        selectedTopic != nil
    }
    
    // MARK: - Methods
    
    func startQuiz(topic: QuizTopic) {
        selectedTopic = topic
        questions = getQuestions(for: topic)
        currentQuestionIndex = 0
        score = 0
        selectedAnswer = nil
        showResult = false
        quizCompleted = false
    }
    
    func selectAnswer(_ index: Int) {
        guard selectedAnswer == nil else { return }
        selectedAnswer = index
        if let question = currentQuestion, index == question.correctAnswer {
            score += 1
        }
        showResult = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showResult = false
        } else {
            quizCompleted = true
        }
    }
    
    func resetQuiz() {
        selectedTopic = nil
        currentQuestionIndex = 0
        score = 0
        selectedAnswer = nil
        showResult = false
        quizCompleted = false
    }
    
    func handleBackButton() -> Bool {
        // Returns true if should dismiss, false if should reset
        if selectedTopic == nil {
            return true
        } else {
            resetQuiz()
            return false
        }
    }
    
    func getAnswerColor(for index: Int) -> Color {
        guard let question = currentQuestion else { return Color.white.opacity(0.8) }
        
        if showResult && index == question.correctAnswer {
            return Color.green.opacity(0.7)
        } else if showResult && index == selectedAnswer && index != question.correctAnswer {
            return Color.red.opacity(0.7)
        } else {
            return Color.white.opacity(0.8)
        }
    }
    
    func shouldShowCheckmark(for index: Int) -> Bool {
        guard let question = currentQuestion else { return false }
        return showResult && index == question.correctAnswer
    }
    
    func shouldShowXmark(for index: Int) -> Bool {
        guard let question = currentQuestion else { return false }
        return showResult && index == selectedAnswer && index != question.correctAnswer
    }
    
    func getAnswerLabel(for index: Int) -> String {
        let labels = ["A", "B", "C"]
        guard index < labels.count else { return "" }
        return labels[index] + ")"
    }
    
    func getQuestions(for topic: QuizTopic) -> [QuizQuestion] {
        switch topic {
        case .colors:
            return [
                QuizQuestion(question: "What color do you get when you mix red and blue?", options: ["Green", "Purple", "Orange"], correctAnswer: 1),
                QuizQuestion(question: "What is the color of the sun?", options: ["Yellow", "Red", "Blue"], correctAnswer: 0),
                QuizQuestion(question: "What color is grass?", options: ["Blue", "Green", "Yellow"], correctAnswer: 1),
                QuizQuestion(question: "What color do you get when you mix red and yellow?", options: ["Orange", "Green", "Purple"], correctAnswer: 0),
                QuizQuestion(question: "What is the color of snow?", options: ["Black", "White", "Gray"], correctAnswer: 1),
                QuizQuestion(question: "What color is the sky on a sunny day?", options: ["Green", "Blue", "Red"], correctAnswer: 1),
                QuizQuestion(question: "What color are most apples?", options: ["Blue", "Red", "Yellow"], correctAnswer: 1),
                QuizQuestion(question: "What color do you get when you mix blue and yellow?", options: ["Red", "Green", "Purple"], correctAnswer: 1),
                QuizQuestion(question: "What is the color of chocolate?", options: ["White", "Brown", "Yellow"], correctAnswer: 1),
                QuizQuestion(question: "What color are bananas?", options: ["Red", "Yellow", "Blue"], correctAnswer: 1)
            ]
        case .food:
            return [
                QuizQuestion(question: "What do you use to make a sandwich?", options: ["Bread", "Water", "Paper"], correctAnswer: 0),
                QuizQuestion(question: "What is a common breakfast food?", options: ["Pizza", "Eggs", "Ice cream"], correctAnswer: 1),
                QuizQuestion(question: "What fruit is red and round?", options: ["Banana", "Apple", "Orange"], correctAnswer: 1),
                QuizQuestion(question: "What do you drink in the morning?", options: ["Juice", "Soup", "Cake"], correctAnswer: 0),
                QuizQuestion(question: "What is made from milk?", options: ["Bread", "Cheese", "Rice"], correctAnswer: 1),
                QuizQuestion(question: "What vegetable is orange and long?", options: ["Broccoli", "Carrot", "Lettuce"], correctAnswer: 1),
                QuizQuestion(question: "What do you eat with soup?", options: ["Fork", "Spoon", "Knife"], correctAnswer: 1),
                QuizQuestion(question: "What is a sweet dessert?", options: ["Salt", "Cake", "Pepper"], correctAnswer: 1),
                QuizQuestion(question: "What fruit is yellow and curved?", options: ["Apple", "Banana", "Grape"], correctAnswer: 1),
                QuizQuestion(question: "What do you put on bread?", options: ["Water", "Butter", "Salt"], correctAnswer: 1)
            ]
        case .cloth:
            return [
                QuizQuestion(question: "What do you wear on your feet?", options: ["Hat", "Shoes", "Gloves"], correctAnswer: 1),
                QuizQuestion(question: "What keeps you warm in winter?", options: ["Shorts", "Coat", "Sandals"], correctAnswer: 1),
                QuizQuestion(question: "What do you wear on your head?", options: ["Socks", "Hat", "Belt"], correctAnswer: 1),
                QuizQuestion(question: "What covers your legs?", options: ["Shirt", "Pants", "Scarf"], correctAnswer: 1),
                QuizQuestion(question: "What do you wear on your hands in cold weather?", options: ["Shoes", "Gloves", "Hat"], correctAnswer: 1),
                QuizQuestion(question: "What do you wear on your upper body?", options: ["Pants", "Shirt", "Socks"], correctAnswer: 1),
                QuizQuestion(question: "What do you wear around your neck?", options: ["Belt", "Scarf", "Hat"], correctAnswer: 1),
                QuizQuestion(question: "What do you wear on your feet inside shoes?", options: ["Gloves", "Socks", "Hat"], correctAnswer: 1),
                QuizQuestion(question: "What is a piece of clothing for sleeping?", options: ["Coat", "Pajamas", "Shoes"], correctAnswer: 1),
                QuizQuestion(question: "What holds up your pants?", options: ["Hat", "Belt", "Scarf"], correctAnswer: 1)
            ]
        case .animals:
            return [
                QuizQuestion(question: "Which animal is known as the king of the jungle?", options: ["Tiger", "Elephant", "Lion"], correctAnswer: 2),
                QuizQuestion(question: "What animal says 'meow'?", options: ["Dog", "Cat", "Cow"], correctAnswer: 1),
                QuizQuestion(question: "What is the largest animal in the ocean?", options: ["Shark", "Whale", "Dolphin"], correctAnswer: 1),
                QuizQuestion(question: "What animal has a long trunk?", options: ["Giraffe", "Elephant", "Horse"], correctAnswer: 1),
                QuizQuestion(question: "What animal is known for hopping?", options: ["Dog", "Rabbit", "Cat"], correctAnswer: 1),
                QuizQuestion(question: "What animal has black and white stripes?", options: ["Tiger", "Zebra", "Horse"], correctAnswer: 1),
                QuizQuestion(question: "What animal says 'woof'?", options: ["Cat", "Dog", "Bird"], correctAnswer: 1),
                QuizQuestion(question: "What is the tallest animal?", options: ["Elephant", "Giraffe", "Horse"], correctAnswer: 1),
                QuizQuestion(question: "What animal lives in water and on land?", options: ["Fish", "Frog", "Bird"], correctAnswer: 1),
                QuizQuestion(question: "What animal has a shell?", options: ["Snake", "Turtle", "Lizard"], correctAnswer: 1)
            ]
        case .flowers:
            return [
                QuizQuestion(question: "What flower is known for its thorns?", options: ["Tulip", "Rose", "Sunflower"], correctAnswer: 1),
                QuizQuestion(question: "What flower follows the sun?", options: ["Rose", "Sunflower", "Daisy"], correctAnswer: 1),
                QuizQuestion(question: "What flower is white and has a yellow center?", options: ["Rose", "Daisy", "Tulip"], correctAnswer: 1),
                QuizQuestion(question: "What flower blooms in spring?", options: ["Sunflower", "Tulip", "Rose"], correctAnswer: 1),
                QuizQuestion(question: "What flower is often red?", options: ["Daisy", "Rose", "Sunflower"], correctAnswer: 1),
                QuizQuestion(question: "What flower is tall and yellow?", options: ["Rose", "Tulip", "Sunflower"], correctAnswer: 2),
                QuizQuestion(question: "What flower has many petals?", options: ["Daisy", "Rose", "Tulip"], correctAnswer: 1),
                QuizQuestion(question: "What flower grows from a bulb?", options: ["Sunflower", "Tulip", "Daisy"], correctAnswer: 1),
                QuizQuestion(question: "What flower is often given on Valentine's Day?", options: ["Daisy", "Rose", "Sunflower"], correctAnswer: 1),
                QuizQuestion(question: "What flower is simple and white?", options: ["Rose", "Daisy", "Tulip"], correctAnswer: 1)
            ]
        }
    }
}

