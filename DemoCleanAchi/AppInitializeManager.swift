//
//  AppInitializeManager.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/3/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
// file config app

import Foundation
import RxSwift
class AppInitializeManager {
    
    static let instance = AppInitializeManager()
    
    var initialized = false
    private let disposeBag = DisposeBag()
    
    private init() {
    }
    
    func prepare(_ application: UIApplication, callback:@escaping () -> Void) {
        Observable<Void>.merge(
            Observable<Void>.create {e in RealmInit().run(e); return Disposables.create();})
            .debug("AppInitializeManager", trimOutput: false)
            .subscribe(onNext: {
                
            }, onError: {[weak self] _ in
                self?.initialized = true
                }, onCompleted: {[weak self] in
                    self?.initialized = true
                    callback()
            })
            .disposed(by: disposeBag)
        
    }
}

protocol Task {
    func run(_ observer: AnyObserver<Void>)
}

class RealmInit: Task {
    func run(_ observer: AnyObserver<Void>) {
        RealmDao.realmInit()
        observer.onCompleted()
    }
}
