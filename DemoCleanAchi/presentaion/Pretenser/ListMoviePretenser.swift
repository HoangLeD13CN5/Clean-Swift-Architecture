//
//  ListMoviePretenser.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift
class ListMoviePretenser:Pretenser{
    typealias T = ListMovieView
    var view:ListMovieView!
    var disposiBag:DisposeBag = DisposeBag()
    
    var movieUC:MovieUseCase!
    var movies:Array<MovieModel> = Array()
    
    init(movieUC:MovieUseCase) {
        self.movieUC = movieUC
    }
    
    func attachView(view: ListMovieView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
   
    func getListMovies(){
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (timer:Timer) in
            self.movieUC.getMovies()
                .observeOn(SerialDispatchQueueScheduler(qos: .default))
                .subscribeOn(MainScheduler.instance)
                .subscribe{ array in
                    if let movies = array.element{
                        let beforeSize = self.movies.count
                        for number in 0..<(movies.count-1){
                            self.movies.append(movies[number])
                        }
                        let currentSize = self.movies.count
                        self.view.loadMoviesSuccess(load: beforeSize,size: currentSize)
                    }
                }
                .disposed(by: self.disposiBag)
        })
    }
    
    func refreshListMovies() {
        self.movies.removeAll()
        self.view?.refreshData()
        getListMovies()
    }
    
    func clickMovieItem(position:Int){
        print("Index: \(position)")
    }
}
