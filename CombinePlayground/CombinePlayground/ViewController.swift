//
//  ViewController.swift
//  CombinePlayground
//
//  Created by Djuro on 3/8/21.
//

import UIKit
import Combine

struct User: Decodable {
    
    // MARK: - Properties
    let name: String
    let company: Company

}

struct Company: Decodable {
    
    // MARK: - Properties
    let name: String
    
}

class DataManager {
    
    // MARK: - Properties
    var usersPublisher: AnyPublisher<[User], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Unable to form URL") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}

class ViewController: UIViewController {

    // MARK: - Properties
    private var usersSubscriber: AnyCancellable?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readStrings()
        fetchUsers()
    }
    
    // MARK: - Private API
    private func readStrings() {
        _ = getStrings().sink { completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        } receiveValue: { strings in
            print(strings)
        }
    }
    
    private func getStrings() -> Future<[String], Error> {
        return Future { promise in
            promise(.success(["A", "B"]))
        }
    }
    
    private func fetchUsers() {
        usersSubscriber = DataManager().usersPublisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }, receiveValue: { users in
            print(users)
        })
    }

}
