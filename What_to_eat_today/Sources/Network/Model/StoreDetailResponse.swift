//
//  storeDetailResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/21.
//

import Foundation

struct StoreDetailResponse: Codable {
    let storeName: String
    let category: String
    let imageUrl: String?
    let keywords: [Keyword]
    let tags: [String: Int]
    let status: Bool?
    let phoneNumber: String?
    let address: String
    let time: String
    let imageCount: Int
    let x: Double
    let y: Double
    let isWishlist: Bool
    
    struct Keyword: Codable {
        let tag: String
        let rank: Int
    }
}
