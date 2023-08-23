//
//  TabBar.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/04.
//

import SwiftUI

class TabBarConfig: ObservableObject {
    @Published var tabBar: Bool = true
    
    func hideTabBar() {
        tabBar = false
    }
    
    func showTabBar() {
        tabBar = true
    }
}
