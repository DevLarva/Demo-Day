//
//  MapListResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/21.
//

import Foundation

struct MapListResponse: Codable {
    let campers : CampersMap
    let stores : [StoreMap]
}

struct CampersMap: Codable {
    let x: Float
    let y: Float
}

struct StoreMap: Codable {
    let id: String
    let x: Float
    let y: Float
    let isWishlist: Bool
}
