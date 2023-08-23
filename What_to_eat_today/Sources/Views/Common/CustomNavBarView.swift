//
//  CustomNavBarView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/27.
//

import SwiftUI
// MARK: - 1. 기본
struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if (showBackButton) {
                backButton // 뒤로가기
            }
            titleSection // 타이틀 영역
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
}
extension CustomNavBarView {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("navi-back")
                .frame(width: 38, height: 38)
        }
    }
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
        }
    }
}

// MARK: - 2. 네비 영역에 왼쪽 부분 텍스트만
struct CustomNavBarViewsec: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            titleSectionsec
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
}


extension CustomNavBarViewsec {
    private var titleSectionsec: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                Font.custom("Pretendard", size: 20)
                .weight(.semibold)
                )
                .foregroundColor(Color.black)
 
            
        }
    }
}


// MARK: - 3. 네비 영역에 왼쪽 부분 back버튼, 오른쪽은 텍스트
struct CustomNavBarViewthr: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let curNum: Int // 시작 숫자
    let finNum: Int // 끝 숫자
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if (showBackButton) {
                backButton // 뒤로가기
            }
            Spacer()
            titleSectionsec
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
}




extension CustomNavBarViewthr {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("navi-back")
                .frame(width: 38, height: 38)
        }
    }
    private var titleSectionsec: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("\(curNum) / \(finNum)")
                .font(Font.custom("Pretendard", size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.GrayScale400)
        }
    }
}

// MARK: - 4. 흰색 버젼
struct CustomNavBarViewfour: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if (showBackButton) {
                backButton // 뒤로가기
                
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
}
extension CustomNavBarViewfour {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("whiteback")
                .frame(width: 38, height: 38)
        }
    }
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
        }.background(Color.clear)
    }
}

// MARK: - 5. 홈 카테고리 버젼

struct CustomNavBarViewcat: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if (showBackButton) {
                backButton // 뒤로가기
            }
            titleSection // 타이틀 영역
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
        .frame(width: UIScreen.main.bounds.width, height: 58, alignment: .leading)
    }
    
}

extension CustomNavBarViewcat {
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("navi-back")
                .frame(width: 38, height: 38)
        }
    }
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(
                    Font.custom("Pretendard", size: 17)
                        .weight(.semibold)
                )
        }.background(Color.clear)
    }
}




struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            CustomNavBarView(showBackButton: true, title: "검색")
//            CustomNavBarViewsec(title: "경상대학교")
//            
//            CustomNavBarViewthr(showBackButton: true, title: "1/5")
//            
//            CustomNavBarViewfour(showBackButton: true, title: "검색")
        }
    }
}



//
