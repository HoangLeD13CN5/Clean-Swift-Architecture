//
//  MovieDao.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/3/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
class MovieDao: RealmDao<RlmMovie> {
   
    func createOrUpdateMovie(_ val: MoviesEntity) -> Observable<MoviesEntity>{
        let rlmMovie = RlmMovie()
        rlmMovie.id = incrementID()
        rlmMovie.name = val.name
        rlmMovie.url = val.url
        rlmMovie.timestamp = val.timestamp
        do{
           try createOrUpdate(rlmMovie)
        }catch{}
       return Observable.create{emitter in
            emitter.onNext(val)
            return Disposables.create()
        }
    }
    
    func findAllMovie() -> Observable<Array<RlmMovie>> {
        do {
            if let results = try super.findAll(RlmMovie.self)?.toArray(ofType: RlmMovie.self) {
                return Observable<Array<RlmMovie>>.create{emitter in
                    emitter.onNext(results);
                    return Disposables.create();
                }
            }
        } catch{}
        return Observable<Array<RlmMovie>>.create{emitter in
            emitter.onNext(Array());
            return Disposables.create();
        }
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(RlmMovie.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func numberMovies() -> Observable<Int>{
        var count:Int = -1
        do{
            count =  try super.count(RlmMovie.self)
        }catch{}
        return Observable.create{ emitter in
                emitter.onNext(count)
                return Disposables.create()
            }
    }
}
