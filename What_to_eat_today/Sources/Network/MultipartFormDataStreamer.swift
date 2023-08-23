//
//  MultipartFormDataStreamer.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/14.
//

import SwiftUI
import Alamofire

class MultipartFormDataStreamer {
    
    private let dto: RegisterRequest
    private let image: UIImage?
    
    init(dto: RegisterRequest, image: UIImage? = nil) {
        self.dto = dto
        self.image = image
    }
    
    func encode(_ request: URLRequest) throws -> URLRequest {
        var urlRequest = request
        
        let formData = MultipartFormData()
        let jsonData = try? JSONEncoder().encode(dto)
        
        if let data = jsonData {
            formData.append(data, withName: "dto")

            // JSON 데이터를 문자열로 변환하여 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Data: \(jsonString)")
            }
        }
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1) {
            formData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }
        
        urlRequest.httpBody = try? formData.encode()
        
        return urlRequest
    }
}

class CreateReviewFormDataStreamer {
    private let dto: CreateReviewRequest
    private let images: UIImage?
    
    init(dto: CreateReviewRequest, images: UIImage? = nil) {
        self.dto = dto
        self.images = images
    }
    
    func encode(_ request: URLRequest) throws -> URLRequest {
        var urlRequest = request
        
        let formData = MultipartFormData()
        let jsonData = try? JSONEncoder().encode(dto)
        
        if let data = jsonData {
            formData.append(data, withName: "dto")

            // JSON 데이터를 문자열로 변환하여 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Data: \(jsonString)")
            }
        }
        
        if let images = images, let imageData = images.jpegData(compressionQuality: 0.2) {
            formData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }
        urlRequest.httpBody = try? formData.encode()
        
        return urlRequest
    }
}

class UpdateReviewFormDataStreamer {
    private let dto: UpdateReviewRequest
    private let image: UIImage?
    
    init(dto: UpdateReviewRequest, image: UIImage? = nil) {
        self.dto = dto
        self.image = image
    }
    
    func encode(_ request: URLRequest) throws -> URLRequest {
        var urlRequest = request
        
        let formData = MultipartFormData()
        let jsonData = try? JSONEncoder().encode(dto)
        
        if let data = jsonData {
            formData.append(data, withName: "dto")

            // JSON 데이터를 문자열로 변환하여 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Data: \(jsonString)")
            }
        }
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1) {
            formData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }
        
        urlRequest.httpBody = try? formData.encode()
        
        return urlRequest
    }
}

class inqueryWriteFormDataStreamer {

    private let dto: InquiryResponse
    private let image: UIImage?

    init(dto: InquiryResponse, image: UIImage? = nil) {
        self.dto = dto
        self.image = image
    }

    func encode(_ request: URLRequest) throws -> URLRequest {
        var urlRequest = request

        let formData = MultipartFormData()
        let jsonData = try? JSONEncoder().encode(dto)

        if let data = jsonData {
            formData.append(data, withName: "dto")

            // JSON 데이터를 문자열로 변환하여 출력
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Data: \(jsonString)")
            }
        }

        if let image = image, let imageData = image.jpegData(compressionQuality: 1) {
            formData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }

        urlRequest.httpBody = try? formData.encode()

        return urlRequest
    }
}
