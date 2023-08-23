//
//  ReviewedStoresResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/22.
//

import Foundation

typealias ReviewedStoresResponse = [ReviewedStore]

struct ReviewedStore: Codable {
    let storeId: String
    let name: String
    let rank: [Rank]
    let status: Bool?
    let score: Double
    let reviewCount: Int
    let time: String
    let imageUrl: String?
    let reviewContent: String?
    let isWishlist: Bool
}

extension ReviewedStore: Identifiable {
    var id: String { storeId }
}
