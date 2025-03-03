//
//  Actions.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import Foundation

enum AppAction {
    case goToNextScreen
    case showPaywall
    case hidePaywall
    case quiz(action: QuizAction)
}

enum QuizAction {
    case startQuiz
    case loadQuizSuccess([Question])
    case loadQuizFailure(Error)
    case nextQuestion
    case prevQuestion
    case selectAnswer(questionId: Int, answerId: UUID)
}
