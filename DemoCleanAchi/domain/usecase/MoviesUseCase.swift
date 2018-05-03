//
//  MoviesUseCase.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift
class MovieUseCase {
    var moviesRepos:MoviesRepos
    
    init(moviesRepos:MoviesRepos) {
        self.moviesRepos = moviesRepos
    }
    
    func getMovies() -> Observable<Array<MovieModel>> {
        return moviesRepos.getMovies()
    }
}
