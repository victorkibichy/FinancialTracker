import Foundation
import Combine

class NetworkingManager {
    static let manager = URLSession(configuration: .default)
    
    static func download(url: URL) -> AnyPublisher<Data, URLError> {
        return manager.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<URLError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Networking error: \(error)")
        }
    }
}