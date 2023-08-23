//
//  ReviewFilter.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/23.
//

import Foundation

struct ReviewFilter: Identifiable {
    let id = UUID().uuidString
    let title: String
}

extension ReviewFilter {
    static let myreviewFilter: [ReviewFilter] = [
        ReviewFilter(title: "수정"),
        ReviewFilter(title: "삭제")
    ]
    static let otherReviewsFilter: [ReviewFilter] = [
        ReviewFilter(title: "신고")
    ]
}
