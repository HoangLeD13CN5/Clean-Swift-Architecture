//
//  ListMovieView.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
protocol ListMovieView {
    func loadMoviesSuccess( load:Int, size:Int)
    func refreshData()
}
