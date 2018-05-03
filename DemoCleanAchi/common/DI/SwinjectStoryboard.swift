//
//  SwinjectStoryboard.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import SwinjectStoryboard
import Swinject
extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(MoviesRepos.self) { _ in
            MovieRepository()
        }
        
        defaultContainer.register(MovieUseCase.self){
            r in MovieUseCase(moviesRepos: r.resolve(MoviesRepos.self)!)
        }
        
        defaultContainer.storyboardInitCompleted(ViewController.self) { r, c in
            c.listMoviePretenser = ListMoviePretenser(movieUC: r.resolve(MovieUseCase.self)!)
        }
    }
}

