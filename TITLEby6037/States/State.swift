//
//  Satte.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import Foundation

struct AppState {
    var selectedAnswers: [Int: String] = [:]
    var currentScreen: Screen = .intro
    var isPaywallVisible: Bool = false
    var quizState: QuizState
}

struct QuizState {
    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    var selectedAnswers: [Int: Set<UUID>] = [:]
}

enum Screen {
    case intro, onboarding, quiz, paywall
}
