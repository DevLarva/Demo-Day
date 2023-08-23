//
//  File.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/16.
//

import Foundation
import SwiftUI

struct Gallery: View {
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        
        
        VStack(spacing: 20) {
            
            if let image = image {
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
            } else {
                Image(systemName: "plus.viewfinder")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 120, height: 120)
            }
               
                       
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Image Picker")
            }
            .sheet(isPresented: $showImagePicker, onDismiss: {
                loadImage()
            }) {
                ImagePicker(image: $selectedUIImage)
        }
        }
        
        
    }
}
