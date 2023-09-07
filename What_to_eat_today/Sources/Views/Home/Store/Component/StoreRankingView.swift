//
//  StoreRankingView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/12.
//

import SwiftUI

//let tags: [String: Int]

// MARK: - 랭킹 뷰
struct StoreRankingView: View {
    let rankingData: [StoreRankingData]
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(rankingData) { store in
                StoreRankingElementView(tag: store.tag, rank: store.rank)
            }
        }
        .frame(width: 400, alignment: .topLeading)
        .background(Color.GrayScale50)
    }
}



// MARK: - 랭킹 요소
struct StoreRankingElementView: View {
    let rankingData: StoreRankingData
    
    init(tag: String, rank: Int) {
        let imageName = Self.imageName(from: tag)
        self.rankingData = StoreRankingData(imageName, tag, rank)
    }
    
    static func imageName(from tag: String) -> String {
        if tag.contains("밥약") {
            return "ranking-babyak"
        } else if tag.contains("혼밥") {
            return "ranking-solo"
        }else if tag.contains("가성비") {
            return "gasungb"
        }else if tag.contains("술약속") {
            return "sulyak"
        }else {
            return "ranking-group"
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 8) {
            //이미지
            Image(rankingData.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
            
            //텍스트
            HStack(alignment: .center, spacing: 4) {
                Text("\(rankingData.tag)랭킹")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.62))
                
                Text(String(rankingData.rank) + "등")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .kerning(0.1)
                    .foregroundColor(rankingData.rank >= 1 && rankingData.rank <= 3 ? Color(red: 1, green: 0.3, blue: 0.15) : Color(red: 0.25, green: 0.25, blue: 0.26)) // 1~3 주황색, 4부터 검정
            }
            .padding(0)
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .top)
    }
    
    func imageName(from tag: String) -> String {
        if tag.contains("밥약") {
            return "ranking-babyak"
        } else if tag.contains("혼밥") {
            return "ranking-solo"
        }else if tag.contains("가성비") {
            return "gasungb"
        }else if tag.contains("술약속") {
            return "sulyak"
        }else {
            return "ranking-group"
        }
    }
    
    
    
    
}

struct StoreRankingData {
    let imageName: String
    var tag: String
    var rank: Int
    
    init(_ imageName: String, _ tag: String, _ rank: Int) {
        self.imageName = imageName
        self.tag = tag
        self.rank = rank
    }
}

extension StoreRankingData: Identifiable {
    var id: String { tag }
}


//struct StoreRankingView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreRankingView()
//    }
//}
