//
//  ApiErrorResult.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import SwiftyJSON
class ApiErrorResult:Error{
    var message: String?
    var errorCodes: Array<String>?
    
    init(_ val: Any) {
        let json = JSON(val)
        self.message = json["message"].string
        
        self.errorCodes = Array<String>()
        if let codes = json["error_codes"].array {
            for code in codes {
                if let str = code.string {
                    self.errorCodes?.append(str)
                }
            }
        }
    }
}
