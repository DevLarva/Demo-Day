//
//  ContentView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/06/13.
//

import SwiftUI

struct ContentView: View {
    @Binding var isLogged: Bool?
    @State private var selection = 2
    
    init(isLogged: Binding<Bool?>) {
         self._isLogged = isLogged
         UITabBar.appearance().backgroundColor = UIColor.white
     }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                PickView()
                    .tabItem {
                        Image(selection == 0 ? "clickheart" : "nonclickheart")
                        Text("찜")
                            .font(Font.custom("Pretendard", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(0)
                MapViewSE()
                    .tabItem {
                        Image(selection == 1 ? "clickmap" : "nonclickmap")
                        Text("지도")
                            .font(Font.custom("Pretendard", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(1)
                
                HomeView()
                    .tabItem {
                        Image(selection == 2 ? "clickhome" : "nonclickhome")
                        Text("홈")
                            .font(Font.custom("Pretendard", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(2)
                ReviewMain()
                    .tabItem {
                        Image(selection == 3 ? "clickpencil" : "nonclickpencil")
                        Text("리뷰")
                            .font(Font.custom("Pretendard", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(3)
                
                MyPageView(isLogged: $isLogged)
                    .tabItem {
                        Image(selection == 4 ? "clickperson" : "nonclickperson")
                        Text("마이페이지")
                            .font(Font.custom("Pretendard", size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .tag(4)
            }
        }.accentColor(.PrimaryOrange300)
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var test: Bool? = true
    static var previews: some View {
        ContentView(isLogged: $test)
    }
}
