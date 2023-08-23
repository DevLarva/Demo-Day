//
//  Inquiry.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/13.
//

import Foundation

struct InquiryResponse: Codable {
    let Inquirys: [Inquiry]
}

struct Inquiry: Codable, Identifiable {
    let id = UUID()
    let title: String
    let content: [Camper]
}
