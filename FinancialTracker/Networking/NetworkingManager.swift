//
//  NetworkingManager.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//


import Foundation
import Combine


import Foundation
import Combine

class NetworkingManager {
    static func download(url: URL) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("DEBUG: Networking error → \(error.localizedDescription)")
        }
    }
}
