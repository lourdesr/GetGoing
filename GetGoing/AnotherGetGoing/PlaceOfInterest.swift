//
//  PlaceOfInterest.swift
//  AnotherGetGoing
//
//  Created by Alla Bondarenko on 2018-06-18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceOfInterest {
    
    var id: String
    var name: String
    var rating: Double?
    var location: CLLocation?
    var formattedAddress: String?
    var iconUrl: String?
    var placeId: String?
    var phone_number: String?
    var website: String?
    
    init?(json: [String: Any]){
        
        guard let id = json["id"] as? String else {
            return nil
        }
        guard let name = json["name"] as? String else {
            return nil
        }
        self.id = id
        self.name = name
        self.placeId = json["place_id"] as? String
        self.rating = json["rating"] as? Double
        self.formattedAddress = json["formatted_address"] as? String
        self.iconUrl = json["icon"] as? String
        
        self.phone_number = json["formatted_phone_number"] as? String

        self.website = json["website"] as? String
        
        
        if let geometry = json["geometry"] as? [String: Any] {
            if let locationCoordinate = geometry["location"] as? [String: Double
                ] {
                if locationCoordinate["lat"] != nil, locationCoordinate["lng"] != nil {
                    self.location = CLLocation(latitude: locationCoordinate["lat"]!, longitude: locationCoordinate["lng"]!)
                }
            }
        }
        
    }
    
    
}
