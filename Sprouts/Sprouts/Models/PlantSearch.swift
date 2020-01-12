//
//  PlantSearch.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation


struct SearchPlant: Codable {
    let slug, scientificName: String
    let link: String
    let id: Int
    let completeData: Bool
    let commonName: String?

    enum CodingKeys: String, CodingKey {
        case slug
        case scientificName = "scientific_name"
        case link, id
        case completeData = "complete_data"
        case commonName = "common_name"
    }
}

typealias SearchResults = [SearchPlant]
