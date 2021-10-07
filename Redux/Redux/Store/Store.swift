//
//  Store.swift
//  Redux
//
//  Created by Djuro on 10/7/21.
//

import Foundation

let store = Store(reducer: reducer)

typealias Reducer = (State, Action) -> State

protocol Action { }

struct IncrementAction: Action { }

func reducer(state: State, action: Action) -> State {
    var state = state
    
    switch action {
    case _ as IncrementAction:
        state.counter += 1
    case let action as SetMoviesAction:
        state.movies = action.movies
    default:
        break
    }
    
    return state
}

final class Store: ObservableObject {
    
    // MARK: - Properties
    var reducer: Reducer
    @Published private (set) var state: State
    
    // MARK: - Initializer
    init(reducer: @escaping Reducer, state: State = State()) {
        self.reducer = reducer
        self.state = state
    }
    
    // MARK: - Public API
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
    }
    
}
