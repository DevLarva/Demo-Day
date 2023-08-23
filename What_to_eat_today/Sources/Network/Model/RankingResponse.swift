//
//  RankingResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/22.
//

import Foundation

struct RankingResponse: Codable {
    let 밥약: [RankStore]
    let 가성비: [RankStore]
    let 혼밥: [RankStore]
    let 단체: [RankStore]
    let 술약속: [RankStore]
}

struct RankStore: Codable {
    var id: String
    var name: String
    var category: String
    var time: String
    var score: Float
    var reviewCount: Int?
    var imageURL: String?
    var reviewContent: String?
    var wishlist: Bool
}
