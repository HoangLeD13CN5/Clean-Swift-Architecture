//
//  MovieRepository.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift
class MovieRepository: MoviesRepos {

    func createOrUpdateMovies(arr: Array<MoviesEntity>) -> Observable<Array<MoviesEntity>> {
        let listObservables = arr.map{ movie in
            MovieDao().createOrUpdateMovie(movie)
                      .catchErrorJustReturn(movie)
        }
        return Observable
            .zip(listObservables,{ array in
                return array
            })
        
    }
    
    func getMovies() -> Observable<Array<MovieModel>> {
        return MovieDao().numberMovies()
            .flatMapLatest{ number -> Observable<Array<MovieModel>> in
                if(number > 0){
                    return MovieDao()
                        .findAllMovie()
                        .map{array in
                            return array.map{ return MapperEntity.instance.convertRlmMovieToModel(movieEntity: $0)}
                    }
                }
                else{
                    return GetMoviesApi()
                        .request()
                        .flatMap{ arr in
                            return self.createOrUpdateMovies(arr: arr)
                        }
                        .map{ array in
                            return array.map{ return MapperEntity.instance.convertMovieEntityToModel(movieEntity: $0)}}
                    
                }
            }
    }
}
