//
//  StoreImageView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/07/29.
//

import SwiftUI

struct StoreImageViewcomponent: View {
    let imageName: String
    let index: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.GrayScale200)
                .frame(width: 109, height: 109)
                .cornerRadius(4)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 109, height: 109)
                        .clipped()
                )
        }
    }
}


// 컬렉션 뷰 -> 이미지 상세보기 가기 전 뷰
struct StoreImageView: View {
    var columns: [GridItem] = Array(repeating: .init(.fixed(110)), count: 3)
    let imageNames = ["matzip", "피자", "한솥"] // Add your image names here
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    CustomNavLink(destination: ImageDetailView(totalImages: imageNames.count, selectedIndex: index, imageName: imageNames[index], imageNames: imageNames)
                    ) {
                        StoreImageViewcomponent(imageName: imageNames[index], index: index)
                    }
                }
            }
            .padding()
        }
    }
}


// 컬렉션 뷰 -> 이미지 상세보기 뷰
struct ImageDetailView: View {
    @State private var currentIndex = 0
    let totalImages: Int
    let selectedIndex: Int
    @State var imageName: String
    let imageNames: [String]
    
    var isAtFirstImage: Bool {
        currentIndex == 0
    }
    
    var isAtLastImage: Bool {
        currentIndex == totalImages - 1
    }
    
    var body: some View {
        
        ZStack {
            
            Color.white
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 375, height: 375)
                    .clipped()
                    .onTapGesture {
                        // Handle tap to go to the next image
                        currentIndex = (currentIndex + 1) % totalImages
                    }
            }
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .trailing) {
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
                            currentIndex = (currentIndex - 1 + totalImages) % totalImages
                            imageName = imageNames[currentIndex]
                        }) {
                            Image("chevron-back")
                                .frame(width: 48, height: 48)
                                .opacity(isAtFirstImage ? 0 : 1.0)//화살표 안보이게
                        }
                        .padding(.leading,0)
                        .disabled(isAtFirstImage) // 첫사진일때 안보이게
                        
                        Spacer()
                        
                        Button(action: {
                            currentIndex = (currentIndex + 1 + totalImages) % totalImages
                            imageName = imageNames[currentIndex] // Update the displayed image
                        }) {
                            Image("chevron-forward")
                                .frame(width: 48, height: 48)
                                .opacity(isAtLastImage ? 0 : 1.0) //화살표 안보이게
                        }
                        .padding(.leading,0)
                        .disabled(isAtLastImage) // 마지막 사진일때 안보이게
                    }
                    // MARK: - 이 부분을 뷰 컴포넌트에 넣어보는건?
                    
                    
                    
                    
                }.frame(height: 500)
                
                HStack {
                    Text("\(currentIndex + 1)/\(imageNames.count)")
                        .font(.headline)
                        .foregroundColor(.GrayScale600)
                        .padding()
                }
                .onAppear {
                    currentIndex = selectedIndex
                    imageName = imageNames[currentIndex]
                }
                
                
            }
            
        }
        .zIndex(0)
        .frame(width: 412, height: 710)
        
        .ignoresSafeArea(.all)
       
        
        
        
        
        
    }
    
}




struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(totalImages: 3, selectedIndex: 1, imageName: "피자", imageNames: ["matzip", "피자", "한솥"])
        
    }
}
