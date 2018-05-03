//
//  MoviesModel.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
class MovieModel {
    var name:String?
    var url:String?
    var timestamp:String?
    init(name:String,url:String,timestamp:String) {
        self.name = name
        self.url = url
        self.timestamp = timestamp
    }
}
