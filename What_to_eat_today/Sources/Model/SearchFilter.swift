//
//  SearchFilter.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/26.
//

import Foundation

struct SearchFilter: Identifiable, Equatable {
    let id = UUID().uuidString
    let title: String
}

// 필터 종류
extension SearchFilter {
    static let searchfilterList: [SearchFilter] = [
        SearchFilter(title: "거리순"),
        SearchFilter(title: "별점순"),
        SearchFilter(title: "리뷰순")
    ]
}
