//
//  RWfooter.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/08/10.
//

import SwiftUI


struct RWfooter: View {
    @Binding var ReviewText: String
    let maxCharacterCount = 200
    let placeholder = "좋았던 점이나 아쉬운점을 적어주세요."
    @State private var showCamera = false
    @Binding var image: UIImage?
    @State var showImagePicker = false
    
    @State var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text("후기 내용")
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
                Button("사진 촬영", role: .none) {
                    showCamera = true
                }
                Button("앨범", role: .none) {
                    showImagePicker.toggle()
                }
                
                Button("취소", role: .cancel) {}
            }.sheet(isPresented: $showCamera) {
                CameraView(image: $image)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
        }.padding(.leading)
        
        
        
    }
}

//struct RWfooter_Previews: PreviewProvider {
//    static var previews: some View {
//        RWfooter()
//    }
//}
