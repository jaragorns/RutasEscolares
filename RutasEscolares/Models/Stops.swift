//
//  Stops.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit
import ObjectMapper

class Stops: Mappable {
    
    // MARK: Params
    
    var latitude  = Double()
    var longitude = Double()
    
    // MARK: Methods
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        latitude  <- map["lat"]
        longitude <- map["lng"]
    }
}
