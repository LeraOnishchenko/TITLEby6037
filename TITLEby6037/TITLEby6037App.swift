//
//  TITLEby6037App.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import SwiftUI

@main
struct TITLEby6037App: App {
    let store = AppStore(initialState: AppState(quizState: QuizState()),
                         reducer: appReducer,
                         middlewares: [quizMiddleware(service: QuizService())])
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
