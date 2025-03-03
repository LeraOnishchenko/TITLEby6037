//
//  Untitled.swift
//  TITLEby6037
//
//  Created by lera on 28.02.2025.
//

import Combine
import Foundation

typealias AppStore = Store<AppState, AppAction>

final class Store<AppState, AppAction>: ObservableObject {
    @Published private(set) var state: AppState
    
    let serialQueue = DispatchQueue(label: "redux.serial.queue")
    
    private let reducer: (inout AppState, AppAction) -> Void
    
    let middlewares: [Middleware<AppState, AppAction>]
    
    private var middlewareCancellables: Set<AnyCancellable> = []
    
    init(initialState: AppState, reducer: @escaping (inout AppState, AppAction) -> Void, middlewares: [Middleware<AppState, AppAction>] = []) {
        self.middlewares = middlewares
        self.state = initialState
        self.reducer = reducer
    }
    
    func dispatch(action: AppAction) {
        for middleware in middlewares {
            if let effect = middleware(state, action) {
                effect
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: dispatch)
                    .store(in: &middlewareCancellables)
            }
        }
        
        reducer(&state, action)
    }
}
