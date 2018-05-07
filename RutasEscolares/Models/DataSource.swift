//
//  DataSource.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit
import ObjectMapper

class DataSource: Mappable {
    
    // MARK: Params
    
    var response        = Bool()
    var schoolBuses     = [SchoolBuses]()
    var stops           = [Stops]()
    var estimatedTime   = Double()
    var retryTime       = Double()
    
    // MARK: Methods
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        response        <- map["response"]
        schoolBuses     <- map["school_buses"]
        stops           <- map["stops"]
        estimatedTime   <- map["estimated_time_milliseconds"]
        retryTime       <- map["retry_time_milliseconds"]
    }
}
