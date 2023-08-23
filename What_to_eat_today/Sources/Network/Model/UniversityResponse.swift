//
//  UniversityResponse.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/12.
//

import Foundation

struct UniversityResponse: Codable {
    let university: [University]
}

struct University: Codable, Identifiable {
    let id = UUID()
    let universityName: String
    let campers: [Camper]
}


struct Camper: Codable, Identifiable {
    let id: String
    let campersName: String

    enum CodingKeys: String, CodingKey {
        case id = "campersId"
        case campersName
    }
}


//struct UniversityResponse: Codable {
//    let university: [University]
//}
//
//struct University: Codable , Identifiable {
//    let id: String // id 프로퍼티 추가
//    let universityName: String
//    let campers: [Camper]
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        universityName = try container.decode(String.self, forKey: .universityName)
//        campers = try container.decode([Camper].self, forKey: .campers)
//        id = universityName // id에 universityName 값을 할당
//    }
//
//    // Codable 등에서 사용될 키 정의
//    enum CodingKeys: String, CodingKey {
//        case universityName, campers
//    }
//}
//
//
//struct Camper: Codable {
//    let campersId: String
//    let campersName: String
//}
