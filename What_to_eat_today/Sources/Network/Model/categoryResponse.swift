//
//  categoryResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import Foundation

struct CategoryResponse: Codable {
    let 한식: [Restaurant]?
    let 중식: [Restaurant]?
    let 양식: [Restaurant]?
    let 일식: [Restaurant]?
    let 분식: [Restaurant]?
    let 아시아: [Restaurant]?
    let 패스트푸드: [Restaurant]?
    let 레스토랑: [Restaurant]?
    let 카페: [Restaurant]?
    let 술집: [Restaurant]?
}

struct Restaurant: Codable {
    let storeId: String
    let name: String
    let category: String
    let rank: [Rank]
    let score: Double
    let status: Bool?
    let reviewCount: Int
    let time: String
    let imageUrl: String?
    let reviewImage: String?
    let reviewContent: String?
    let isWishlist: Bool?
}

extension Restaurant: Identifiable {
    var id: String { storeId }
}


struct Rank: Codable, Hashable{
    let tag: String
    let rank: Int
}
