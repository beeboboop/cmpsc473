//
//  Building.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import Foundation
import MapKit

struct Building : Identifiable, Codable, Hashable  {
    let name : String
    let buildingCode : Int
    let latitude : Double
    let longitude : Double
    let yearConstructed : Int?
    let photo : String?
    var isFavorited : Bool = false
    var isSelected : Bool = false
    var id : Int {self.buildingCode}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.buildingCode = try container.decode(Int.self, forKey: .buildingCode)
        self.yearConstructed = try container.decodeIfPresent(Int.self, forKey: .yearConstructed)
        self.photo = try container.decodeIfPresent(String.self, forKey: .photo)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.isFavorited = try container.decodeIfPresent(Bool.self, forKey: .isFavorited) ?? false
        self.isSelected = try container.decodeIfPresent(Bool.self, forKey: .isSelected) ?? false
    }
    
    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude, photo, isFavorited, isSelected
        case buildingCode = "opp_bldg_code"
        case yearConstructed = "year_constructed"
    }
}
