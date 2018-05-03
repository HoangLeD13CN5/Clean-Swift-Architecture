//
//  RlmMovie.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/3/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RealmSwift
class RlmMovie: Object,StandaloneCopy {
    @objc dynamic var id: Int = 1
    
    @objc dynamic var url: String?
    @objc dynamic var name: String?
    @objc dynamic var timestamp: String?
    
    // MARK: helper
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toStandalone() -> RlmMovie {
        let ret = RlmMovie()
        ret.url = self.url
        ret.name = self.name
        ret.timestamp = self.timestamp
        return ret
    }
}
