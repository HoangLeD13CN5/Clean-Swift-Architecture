//
//  MoviesEntity.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class MoviesEntity:ApiResult{
    var name:String?
    var url:String?
    var timestamp:String?
    
    required init(_ val: NSDictionary) {
        super.init(val)
        var json = JSON(val)
        self.name = json["name"].string
        self.timestamp = json["timestamp"].string
        self.url = json["url"]["medium"].string
    }
    
    init(name:String,url:String,timestamp:String) {
        let val = NSDictionary()
        super.init(val)
        self.name = name
        self.url = url
        self.timestamp = timestamp
    }
}
