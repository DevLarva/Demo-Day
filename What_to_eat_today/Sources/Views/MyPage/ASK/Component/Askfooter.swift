//
//  Askcontent.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/12.
//

import SwiftUI

struct Askfooter: View {
    @State var ReviewText = ""
    let maxCharacterCount = 500
    let placeholder = "문의사항을 적어주세요."
    
    
    @State private var image: UIImage?
    @State var showImagePicker = false
    
    @State var showingSheet = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("내용")
                .font(
                    Font.custom("Pretendard", size: 16)
                        .weight(.medium)
                )
                .foregroundColor(.GrayScale700)
            
            HStack(alignment: .bottom, spacing: 8) {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $ReviewText)
                        .onChange(of: ReviewText) { newValue in
                            if ReviewText.count > maxCharacterCount {
                                ReviewText = String(ReviewText.prefix(maxCharacterCount))
                            }
                        }
                    
                    if ReviewText.isEmpty {
                        Text(placeholder)
                            .padding(.vertical, 8)
                            .font(Font.custom("Pretendard", size: 14))
                            .foregroundColor(.GrayScale500)
                            .padding(.horizontal, 8)
                    }
                }
                
                
            }
            .frame(width: 343, height: 192, alignment: .topLeading)
            .background(Color.GrayScale50)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color.GrayScale300, lineWidth: 1)
            )
            
            
            
            HStack(alignment: .center) {
                Spacer().frame(width: 300)
                Text("\(ReviewText.count) / \(maxCharacterCount)")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.GrayScale500)
            }
            
            Button(action: {
                self.showingSheet = true
            }) {
                if let displayImage = image {
                    Image(uiImage: displayImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    ReviewImageButton()
                }
            }
            .confirmationDialog("타이틀", isPresented: $showingSheet) {
                
                Button("앨범", role: .none) {
                    showImagePicker.toggle()
                }
                
                Button("취소", role: .cancel) {}
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
        }
        
    }
}


struct Askcontent_Previews: PreviewProvider {
    static var previews: some View {
        Askfooter()
    }
}
