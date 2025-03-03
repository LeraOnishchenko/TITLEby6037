//
//  MainView.swift
//  TITLEby6037
//
//  Created by lera on 02.03.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        switch store.state.currentScreen {
        case .intro:
            IntroScreenView().environmentObject(store)
        case .quiz:
            QuizView().environmentObject(store)
        case .paywall:
            PaywallView().environmentObject(store)
        case .onboarding:
            OnboardingView().environmentObject(store)
        }
    }
}
