//
//  Starship.swift
//  StarWarsStarShips
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let results: [Starship]
}

struct Starship: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case cost = "cost_in_credits"
        case speed = "max_atmosphering_speed"
        case films
    }
    
    let name: String
    let model: String
    let cost: String
    let speed: String
    let films: [String]
}

