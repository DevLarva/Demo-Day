//
//  CustomRandomStoreCell.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/26.
//

import SwiftUI

struct CustomRandomStoreCell: View {
    let stores: Stores
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("다른 맛집은 어떠세요?")
                .padding(.bottom, 8)
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .foregroundColor(Color.GrayScale800)
            
            ForEach(0...4, id: \.self) { idx in
                ZStack {
                    NavigationLink(destination: StoreView()) {
                        CustomStoreSimpleCell(store: .constant(stores.stores[idx]))
                    }
                }
                if(idx != 4){
                    Divider()
                }
            }
        }
        .padding(0)
    }
}


struct CustomRandomStoreCell_Previews: PreviewProvider {
    static let test = Stores()
    
    static var previews: some View {
        CustomRandomStoreCell(stores: test)
    }
}
