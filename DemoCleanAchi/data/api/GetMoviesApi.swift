//
//  GetMoviesApi.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import Alamofire
class GetMoviesApi: API<Array<MoviesEntity>> {
    override func convertJson(_ val: Any) throws -> Array<MoviesEntity> {
        guard let value = val as? Array<Dictionary<String, AnyObject>> else { return [] }
        return value.map { MoviesEntity($0 as NSDictionary) }
    }
    
    override func path() -> String {
        return AppUtils.URL_GET_MOVIES
    }
    
    override func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    override func encoding() -> ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func params() -> Parameters {
        return [:]
    }
}
