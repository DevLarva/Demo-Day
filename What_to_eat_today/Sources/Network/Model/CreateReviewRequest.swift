//
//  createReview.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/13.
//

import Foundation

struct CreateReviewRequest: Codable {
    let content: String
    let storeId: String
    let score: Float
    let tags: [String]
    let keywords : [String]
}
