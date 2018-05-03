//
//  MoviesRepos.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesRepos {
    func getMovies() -> Observable<Array<MovieModel>>
}
