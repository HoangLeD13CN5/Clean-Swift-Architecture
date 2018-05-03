//
//  MapperEntity.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
class MapperEntity {
    static let instance = MapperEntity()
    
    func convertMovieEntityToModel(movieEntity:MoviesEntity) -> MovieModel {
        return MovieModel(name: movieEntity.name!,url: movieEntity.url!,timestamp: movieEntity.timestamp!)
    }
    
    func convertRlmMovieToModel(movieEntity:RlmMovie) -> MovieModel {
        return MovieModel(name: movieEntity.name!,url: movieEntity.url!,timestamp: movieEntity.timestamp!)
    }
    
    func convertModelToEntity(movieModel:MovieModel) -> MoviesEntity {
        return MoviesEntity(name: movieModel.name!,url: movieModel.url!,timestamp: movieModel.timestamp!)
    }
}
