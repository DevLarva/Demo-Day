//
//  WriteAskView.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/06.
//

import SwiftUI

struct WriteAskView: View {
    @State var title: String = ""
    @State var content: String = ""
    
    @State private var textCounter: Int = 0
    
    let imageNames: [String] = ["review_image1", "review_image2", "review_image3"]
    
    var body: some View {
        ZStack {
            WriteAskContent
        }
    }
}

extension WriteAskView {
    private var WriteAskContent: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            /// 제목
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top, spacing: 8) {
                    Text("제목")
                        .font(Font.custom("Pretendard", size: 14))
                        .foregroundColor(Color.GrayScale600)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 0)
                .frame(width: .infinity, alignment: .topLeading)
                
                TextField("제목을 입력 해 주세요.", text: $title)
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.GrayScale500)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                    .padding(.vertical, 12)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color.GrayScale300)
            }
            
            /// 내용
            VStack(alignment: .leading, spacing: 12) {
                Text("내용")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(Color.GrayScale600)
                
                VStack(alignment: .trailing, spacing: 4) {
                    TextField("텍스트를 입력하여 주세요.", text: $content)
                        .padding(12)
                        .frame(width: .infinity, height: 192, alignment: .topLeading)
                        .background(Color.GrayScale50)
                        .cornerRadius(8)
                        .onChange(of: content, perform: { _ in updateTextCounter() })
                    
                    Text("(\(textCounter)/500)")
                      .font(Font.custom("Pretendard", size: 14))
                      .foregroundColor(Color.GrayScale500)
                }
            }
            
            /// 사진 업로드
            VStack(alignment: .leading, spacing: 12) {
                // Title2/Regular
                Text("사진 업로드")
                  .font(Font.custom("Pretendard", size: 14))
                  .foregroundColor(Color.GrayScale600)
                  .frame(maxWidth: .infinity, alignment: .topLeading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(imageNames.indices, id: \.self) { index in
                            Image(imageNames[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 120)
                                .clipped()
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: .infinity, alignment: .topLeading)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func updateTextCounter() {
        textCounter = content.count
    }
}

struct WriteAskView_Previews: PreviewProvider {
    static var previews: some View {
        WriteAskView()
    }
}
