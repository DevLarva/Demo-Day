//
//  CustomNavLink.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/27.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    @Binding var isActive: Bool?
    
    init(destination: Destination,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        _isActive = Binding.constant(nil)
    }
    
    init(destination: Destination,
         isActive: Binding<Bool>,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        _isActive = isActive.optionalBinding
    }
    
    var body: some View {
            if let isActive = isActive {
                NavigationLink(destination: CustomNavBarContainerView {
                    destination
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }, isActive: Binding(get: { isActive == true }, set: { self.isActive = $0 ? true : nil })) {
                    label
                }
            } else {
                NavigationLink(destination: CustomNavBarContainerView {
                    destination
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }) {
                    label
                }
            }
            
        
     
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension Binding where Value == Bool {
    var optionalBinding: Binding<Bool?> {
        Binding<Bool?>(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue ?? false
            }
        )
    }
}

// MARK: - 2. 2번 버젼 필요 X

struct CustomNavLinkForSec<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    @Binding var isActive: Bool?
    
    init(destination: Destination,
         
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        
        _isActive = Binding.constant(nil)
    }
    
    init(destination: Destination,
         isActive: Binding<Bool>,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        _isActive = isActive.optionalBinding
    }
    
    var body: some View {
         
            NavigationLink(destination: CustomNavBarTwoContainerView() {
                destination
                    .navigationBarHidden(true)
            }) {
                label
            }
            .navigationBarBackButtonHidden(true)
    }
        
    
}
// MARK: - 3. 3번 버젼
struct CustomNavLinkForThr<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    let curNum: Int
    let finNum: Int
    @Binding var isActive: Bool?
    
    init(destination: Destination,
         curNum: Int,
         finNum: Int,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.curNum = curNum
        self.finNum = finNum
        _isActive = Binding.constant(nil)
    }
    
    init(destination: Destination,
         isActive: Binding<Bool>,
         curNum: Int,
         finNum: Int,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.curNum = curNum
        self.finNum = finNum
        _isActive = isActive.optionalBinding
    }
    
    var body: some View {
        if let isActive = isActive {
            NavigationLink(destination: CustomNavBarThrContainerView(curNum: curNum, finNum: finNum) {
                destination
                    .navigationBarHidden(true)
            }, isActive: Binding(get: { isActive == true }, set: { self.isActive = $0 ? true : nil })) {
                label
            }
        } else {
            NavigationLink(destination: CustomNavBarThrContainerView(curNum: curNum, finNum: finNum) {
                destination
                    .navigationBarHidden(true)
            }) {
                label
            }
        }
    }
    
}
// MARK: - 4. 4번 버젼
// MARK: - 5. 5번 버젼 = 홈에서 카테고리로 가는 뷰

struct CustomNavCatLink<Content: View, Destination: View>: View {
    let content: Content
    let destination: () -> Destination
    let tag: String
    @Binding var selection: String?

    init(destination: @escaping () -> Destination, tag: String, selection: Binding<String?>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.destination = destination
        self.tag = tag
        self._selection = selection
    }

    var body: some View {
        Button {
            selection = tag
        } label: {
            NavigationLink(destination: CustomNavBarCatContainerView {
                destination().navigationBarHidden(true) }, tag: tag, selection: $selection) {
                content
            }
           
        }
    }
}








