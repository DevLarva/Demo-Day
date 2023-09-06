//
//  RecommendResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/09/06.
//

import Foundation

typealias RecommendResponse = [RecommendStore]

struct RecommendStore: Codable, Hashable {
    var id: String
    var name: String
    var category: String
    var time: String
    var status: Bool?
    var score: Float
    var reviewCount: Int
    var imageURL: String?
}
