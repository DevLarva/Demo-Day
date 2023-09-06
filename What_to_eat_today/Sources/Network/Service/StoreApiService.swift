//
//  StoreApiService.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import Foundation
import Alamofire
import Combine

enum StoreApiService {
    //case rank
    static func rank() -> AnyPublisher<RankingResponse, Error> {
        print("StoreApiService - rank() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.rank, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: RankingResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case rankSample
    static func rankSample() -> AnyPublisher<RankSampleResponse, Error> {
        print("StoreApiService - rankSample() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.rankSample, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: RankSampleResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case categorys(orderby: String) ///쿼리 스트링
    static func categorys(orderby: String) -> AnyPublisher<CategoryResponse, Error> {
        print("StoreApiService - categorys() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.categorys(orderby: orderby), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: CategoryResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case getWishlist
    static func getWishlist() -> AnyPublisher<[Restaurant], Error> {
        print("StoreApiService - getWishlist() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.getWishlist, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: [Restaurant].self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case storeDetail(id: String)///패스 스트링
    static func storeDetail(id: String) -> AnyPublisher<StoreDetailResponse, Error> {
        print("StoreApiService - storeDetail() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.storeDetail(id: id), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: StoreDetailResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    
    //case getImages(id: String) ///패스 스트링
    static func getImages(id: String) -> AnyPublisher<[String], Error> {
        print("StoreApiService - getImages() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.getImages(id: id), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: [String].self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case getReviews(id: String, orderby: String, page: Int, limit: Int) ///패스 스트링, 쿼리 스트링
    static func getReviews(id: String, orderby: String, page: Int, limit: Int) -> AnyPublisher<getReviewResponse, Error> {
        print("StoreApiService - getReviews() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.getReviews(id: id, orderby: orderby, page: page, limit: limit), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: getReviewResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case createReview(dto: CreateReviewRequest, image: UIImage?)///form-data
    static func createReview(dto: CreateReviewRequest, images: UIImage?) -> AnyPublisher<Bool, Error> {
        print("StoreApiService - createReview() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return AF.upload(multipartFormData: { multipartFormData in
            let jsonData = try? JSONEncoder().encode(dto)
            if let data = jsonData {
                multipartFormData.append(data, withName: "dto")
            }
            if let images = images, let imageData = images.jpegData(compressionQuality: 1) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, with: StoreRouter.createReview(dto: dto, images: images), interceptor: authInterceptor)
        .validate(statusCode: 200..<300)
        .publishData()
        .tryMap { response -> Bool in
            guard let statusCode = response.response?.statusCode else {
                throw NSError(domain: "서버의 오류로 실패하였습니다.", code: 0, userInfo: nil)
            }
            switch statusCode {
            case 201:
                return true
            case 400:
                throw NSError(domain: "데이터를 입력해주세요", code: 400, userInfo: nil)
            case 401:
                throw NSError(domain: "로그인을 진행해주세요", code: 401, userInfo: nil)
            default:
                throw NSError(domain: "서버의 오류로실패하였습니다.", code: statusCode, userInfo: nil)
            }
        }
        .eraseToAnyPublisher()
    }

    //case deleteReview(reviewid: String)///패스 스트링
    static func deleteReview(reviewid: String) -> AnyPublisher<Bool, Error> {
        print("StoreApiService - deleteReview() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.deleteReview(reviewid: reviewid), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 403:
                    throw NSError(domain: "권한이 없습니다", code: 403, userInfo: nil)
                case 404:
                    throw NSError(domain: "리뷰를 찾을 수 없습니다.", code: 404, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
    //case updateReview(id: Int, dto: UpdateReviewRequest, image: UIImage?)///form-data, 패스스트링
    //case reviewLike(reviewid: String, isLike: Bool)///패스 스트링, json
    //    static func reviewLike(reviewid: String, isLike: Bool) -> AnyPublisher<Bool, Error> {
    //        print("StoreApiService - reviewLike() called")
    //
    //        let storedTokenData = UserDefaultsManager.shared.getTokens()
    //        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
    //                                         refreshToken: storedTokenData.refreshToken,
    //                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
    //
    //        let authenticator = OAuthAuthenticator()
    //        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
    //                                                        credential: credential)
    //
    //        return ApiClient.shared.session
    //            .request(StoreRouter.reviewLike(reviewid: reviewid, isLike: isLike), interceptor: authInterceptor)
    //            .validate(statusCode: 200..<300)
    //            .publishData()
    //            .tryMap { response -> Bool in
    //                guard let statusCode = response.response?.statusCode else {
    //                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: 0, userInfo: nil)
    //                }
    //                switch statusCode {
    //                case 200:
    //                    return true
    //                case 404:
    //                    throw NSError(domain: "이미 찜하지 않은 가게입니다.", code: 404, userInfo: nil)
    //                case 409:
    //                    throw NSError(domain: "이미 찜한 가게입니다.", code: 409, userInfo: nil)
    //                default:
    //                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: statusCode, userInfo: nil)
    //                }
    //            }
    //            .eraseToAnyPublisher()
    //    }
    
    //case .mapList(let distance, let keyword, let category)
    static func mapList(distance: Int, keyword: [String]? = nil, category: [String]? = nil) -> AnyPublisher<MapListResponse ,Error> {
        print("StoreApiService - mapList() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.mapList(distance: distance, keyword: keyword ?? nil, category: category ?? nil), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: MapListResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case mapStoreInfo(storeid: String)///패스 스트링
    static func mapStoreInfo(storeid: String) -> AnyPublisher<Restaurant, Error> {
        print("StoreApiService - mapStoreInfo() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.mapStoreInfo(storeid: storeid), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Restaurant.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case recommendStore
    static func recommendStore() -> AnyPublisher<[RecommendStore], Error> {
        print("StoreApiService - recommendStore() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.recommendStore, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: [RecommendStore].self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case searchStore(keyword: String, orderby: String) // 쿼리스트링
    static func searchStore(keyword: String, orderby: String) -> AnyPublisher<[RecommendStore], Error> {
        print("StoreApiService - searchStore() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.searchStore(keyword: keyword, orderby: orderby), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: [RecommendStore].self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case reviewedStores
    static func reviewedStores() -> AnyPublisher<ReviewedStoresResponse, Error> {
        print("StoreApiService - reviewedStores() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.reviewedStores, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: ReviewedStoresResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    //case myReviews
    static func myReviews() -> AnyPublisher<MyReviewsResponse, Error> {
        print("StoreApiService - myReviews() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.myReviews, interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: MyReviewsResponse.self)
            .value()
            .mapError { $0 as Error } // 에러 타입 변환
            .eraseToAnyPublisher()
    }
    
    //case toggleWishList(storeId: String, isLike: Bool)
    static func toggleWishList(storeId: String, isLike: Bool) -> AnyPublisher<Bool, Error> {
        print("StoreApiService - toggleWishList() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 60 * 120))
        
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        return ApiClient.shared.session
            .request(StoreRouter.toggleWishList(storeId: storeId, isLike: isLike), interceptor: authInterceptor)
            .validate(statusCode: 200..<300)
            .publishData()
            .tryMap { response -> Bool in
                guard let statusCode = response.response?.statusCode else {
                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: 0, userInfo: nil)
                }
                switch statusCode {
                case 200:
                    return true
                case 404:
                    throw NSError(domain: "이미 찜하지 않은 가게입니다.", code: 404, userInfo: nil)
                case 409:
                    throw NSError(domain: "이미 찜한 가게입니다.", code: 409, userInfo: nil)
                default:
                    throw NSError(domain: "서버의 오류로 좋아요를 실패하였습니다.", code: statusCode, userInfo: nil)
                }
            }
            .eraseToAnyPublisher()
    }
}
