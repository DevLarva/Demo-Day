//
//  RankSampleResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/22.
//

import Foundation

struct RankSampleResponse: Codable {
    let 밥약: [RankSample]
    let 가성비: [RankSample]
    let 혼밥: [RankSample]
    let 단체: [RankSample]
    let 술약속: [RankSample]
}

struct RankSample: Codable {
    let id: String
    let name: String
    let time: String
    let category: String
    let tags: [String]
    let isWishlist: Bool
    let imageURL: String?
    let score: Float
}
