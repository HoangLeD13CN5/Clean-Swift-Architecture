//
//  Presenter.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
protocol Pretenser {
    associatedtype T
    func attachView(view:T)
    func detachView()
}
