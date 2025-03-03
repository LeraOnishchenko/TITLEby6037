//
//  Middleware.swift
//  TITLEby6037
//
//  Created by lera on 02.03.2025.
//

import Combine
import Foundation

typealias Middleware<AppState, AppAction> = (AppState, AppAction) -> AnyPublisher<AppAction, Never>?

func quizMiddleware(service: QuizService) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
        case .quiz(action: .startQuiz):
            return service.fetchQuestions()
                .subscribe(on: DispatchQueue.main)
                .map{AppAction.quiz(action: .loadQuizSuccess($0))}
                .catch{err in
                    Just(AppAction.quiz(action: .loadQuizFailure(err)))
                }
                .eraseToAnyPublisher()
        case .quiz(action: .nextQuestion):
            if state.quizState.currentQuestionIndex == state.quizState.questions.count - 1 {
                return service.sendAnswers(selectedAnswers: state.quizState.selectedAnswers)
                    .subscribe(on: DispatchQueue.main)
                    .map{_ in AppAction.goToNextScreen}
                    .eraseToAnyPublisher()
            }
        default:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}
