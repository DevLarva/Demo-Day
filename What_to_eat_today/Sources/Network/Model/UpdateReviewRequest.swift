//
//  updateReview.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/13.
//
//
import Foundation

struct UpdateReviewRequest: Codable {
    let content: String
    let score: Float
//    let tags: [UpdateTag]
//    let keywords : keyword

}

struct UpdateTag: Codable, Identifiable {
    let id = UUID()
    let tag: String
}
