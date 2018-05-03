//
//  StandaloneCopy.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/4/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation

protocol StandaloneCopy {
    associatedtype T
    
    func toStandalone() -> T
    
}
