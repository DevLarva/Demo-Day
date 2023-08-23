//
//  Ranking.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/26.
//

import Foundation
import SwiftUI


struct Ranking: Codable, Identifiable {
    let id: String
    let storename: String
    let storecategory: String
    let ranking: String
    let storedistance: String
    let heart: Bool
    let storestatus: Bool
    let storeimage: String
    let storescore: Double
    let tag: String
    let reviewcount: Int
    let review: String
    let reviewresist: Bool
    let cattag: String
    
    var truncatedReview: String {
        let maxLength = 54
        if reviewresist {
            return review.count > maxLength ? String(review.prefix(maxLength)) + "..." : review
        } else {
            return "리뷰를 준비중입니다. 첫 리뷰를 남겨주세요"
        }
    }
}



var rankingData: [Ranking] = [
    
    Ranking(id: "1",storename: "matzip", storecategory: "한식", ranking: "1등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "밥약", reviewcount:233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    
    Ranking(id: "1",storename: "대박맛", storecategory: "한식", ranking: "1등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "리뷰를 준비중입니다. 첫 리뷰를 남겨주세요", reviewresist: false, cattag: "한식"),
    
    Ranking(id: "1",storename: "대박", storecategory: "한식", ranking: "1등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    Ranking(id: "1",storename: "존맛", storecategory: "한식", ranking: "1등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "밥약", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    Ranking(id: "1",storename: "구워야 맛있다", storecategory: "한식", ranking: "2등",storedistance:"걸어서 15분", heart: true, storestatus: true, storeimage : "dongas", storescore: 5.0, tag: "가성비", reviewcount: 87, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    Ranking(id: "1",storename: "싱싱생생", storecategory: "양식", ranking: "3등",storedistance:"걸어서 5분", heart: false, storestatus: true, storeimage : "salad", storescore: 5.0, tag: "밥약", reviewcount: 112, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    Ranking(id: "1",storename: "한솥", storecategory: "한식", ranking: "4등",storedistance:"걸어서 3분", heart: false, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "혼밥", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: true, cattag: "한식"),
    
    Ranking(id: "1",storename: "학교피자", storecategory: "양식", ranking: "5등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "술약속", reviewcount: 233, review: "이렇게 맛있는데 이가격인게 말이안됨, 진짜 맛있고 소스꼭꼭 추가해야함 안하면 백퍼 후회하니까 추가하는거 추천하고 주변에 주차장도 있어서 편리해", reviewresist: false, cattag: "한식"),
    
    Ranking(id: "1",storename: "학교피자", storecategory: "양식", ranking: "5등",storedistance:"걸어서 10분", heart: true, storestatus: true, storeimage : "matzip", storescore: 5.0, tag: "술약속", reviewcount: 233, review: "리뷰를 준비중입니다. 첫 리뷰를 남겨주세요", reviewresist: false, cattag: "한식"),
]

