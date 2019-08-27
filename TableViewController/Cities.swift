//
//  Cities.swift
//  TableViewController
//
//  Created by Berk Batuhan ŞAKAR on 26.08.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit

//typealias Cities = [String: String]?
//
//struct CitiesModel {
//    var name: String?
//    var plaka: Int
//}

struct CitiesModel: Codable {
    let plaka: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case plaka = "plaka"
        case name = "sehirAdi"
    }
}

typealias Cities = [CitiesModel]


struct IlceElement: Codable {
    let ilceAdi: String
}

typealias Ilce = [IlceElement]
