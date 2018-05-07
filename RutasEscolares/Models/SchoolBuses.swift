//
//  SchoolBuses.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit
import ObjectMapper

class SchoolBuses: Mappable {
    
    // MARK: Params
    
    var id =          Int()
    var name =        String()
    var description = String()
    var stopsUrl =    String()
    var imgUrl =      String()
    
    // MARK: Methods
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        description <- map["description"]
        stopsUrl    <- map["stops_url"]
        imgUrl      <- map["img_url"]
    }
}
