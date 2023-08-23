//
//  MyReviewsResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/22.
//

import Foundation

typealias MyReviewsResponse = [MyReview]

struct MyReview: Codable {
    let id: String
    let nickname: String
    let score: Float
    let content: String
    let tags: [String]
    let images: [String]
    let likeCount: Int
    let createdDate: String
    let userImage: String?
}
