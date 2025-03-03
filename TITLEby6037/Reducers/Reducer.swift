//
//  Reducer.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import Foundation

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .goToNextScreen:
        switch state.currentScreen {
        case .onboarding:
            state.currentScreen = .quiz
        case .quiz:
            state.currentScreen = .paywall
        case .paywall:
            break
        case .intro:
            state.currentScreen = .onboarding
        }
    case .showPaywall:
        state.isPaywallVisible = true
    case .hidePaywall:
        state.isPaywallVisible = false
    case .quiz(action: .startQuiz):
        break
    case let .quiz(action: .loadQuizSuccess(quizState)):
        state.quizState = QuizState(questions: quizState)
        state.currentScreen = .quiz
    case .quiz(action: .loadQuizFailure(_)):
        break
        
    case .quiz(action: .nextQuestion):
        if state.quizState.currentQuestionIndex < state.quizState.questions.count - 1 {
            state.quizState.currentQuestionIndex += 1
        }
    case .quiz(action: .prevQuestion):
        if state.quizState.currentQuestionIndex > 0 {
            state.quizState.currentQuestionIndex -= 1
        }
        
    case .quiz(action: .selectAnswer(questionId: let questionId, answerId: let answerId)):
        let current = state.quizState.questions[state.quizState.currentQuestionIndex]
        if !current.multiSelect {
            var selections = state.quizState.selectedAnswers[questionId] ?? Set<UUID>()
            
            if selections.contains(answerId) {
                selections.remove(answerId)
            } else {
                selections = Set<UUID>()
                selections.insert(answerId)
            }
            state.quizState.selectedAnswers[questionId] = selections
            
            break
        }
        var selections = state.quizState.selectedAnswers[questionId] ?? Set<UUID>()
        
        if selections.contains(answerId) {
            selections.remove(answerId)
        } else {
            selections.insert(answerId)
        }
        state.quizState.selectedAnswers[questionId] = selections
    }
}
