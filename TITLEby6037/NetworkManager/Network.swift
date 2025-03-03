//
//  Network.swift
//  TITLEby6037
//
//  Created by lera on 02.03.2025.
//

import Combine
import Foundation

public struct QuizService {
    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        return NetworkManager()
            .mockGet()
    }
    func sendAnswers(selectedAnswers: [Int: Set<UUID>]) -> AnyPublisher<Void, Never> {
        return NetworkManager()
            .mockSend()
    }
}

struct NetworkManager {
    func mockGet<T:Decodable>() -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
                let error = NSError(domain: "BundleError",
                                    code: 404,
                                    userInfo: [NSLocalizedDescriptionKey: "was not able to found questions.json в Bundle."])
                promise(.failure(error))
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let delay = Double.random(in: 0..<2)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(object))
                    } catch {
                        promise(.failure(error))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func mockSend() -> AnyPublisher<Void, Never> {
        return Future<Void, Never> { promise in
            let delay = Double.random(in: 0..<2)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
