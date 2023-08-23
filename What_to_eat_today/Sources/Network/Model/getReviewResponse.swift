//
//  getReviewResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/21.
//

import Foundation

typealias getReviewResponse = [Review]

struct Review: Codable {
    let reviewId: String
    let nickname: String
    let score: Int
    let tags: [String]
    let createdDate: String
    let likeCount: Int
    let content: String
    let userImage: String?
    enum CodingKeys: String, CodingKey {
        case reviewId
        case nickname
        case score
        case tags
        case createdDate
        case likeCount
        case content
        case userImage
    }
}

extension Review: Identifiable {
    var id: String { reviewId }
}
