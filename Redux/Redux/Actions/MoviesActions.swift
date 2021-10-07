//
//  MoviesActions.swift
//  Redux
//
//  Created by Djuro on 10/7/21.
//

import Foundation

struct GetMoviesAction: Action {
    
    // MARK: - Initializer
    init() {
        MovieService().getMovies(url: Constants.MOVIES_URL) { result in
            switch result {
            case .success(let movies):
                store.dispatch(action: SetMoviesAction(movies: movies))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

struct SetMoviesAction: Action {
    
    // MARK: - Properties
    let movies: [Movie]
    
    // MARK: - Initializer
    init(movies: [Movie]) {
        self.movies = movies
    }
    
}
