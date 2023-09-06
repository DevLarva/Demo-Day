//
//  StoreRouter.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/10.
//

//import Foundation
//import Alamofire

import Foundation
import Alamofire

enum StoreRouter: URLRequestConvertible {
    // MARK: - case 분류
    case rank
    case rankSample
    case categorys(orderby: String) ///쿼리 스트링
    case getWishlist
    case storeDetail(id: String)///패스 스트링
    case getImages(id: String) ///패스 스트링
    case getReviews(id: String, orderby: String, page: Int, limit: Int) ///패스 스트링, 쿼리 스트링
    case createReview(dto: CreateReviewRequest, images: UIImage?)///form-data
    case deleteReview(reviewid: String)///패스 스트링
    case updateReview(id: String, dto: UpdateReviewRequest, image: UIImage?)///form-data, 패스스트링
    case reviewLike(reviewid: String, isLike: Bool)///패스 스트링, json
    case mapList(distance: Int, keyword: [String]?, category: [String]?)
    case mapStoreInfo(storeid: String)///패스 스트링
    case recommendStore
    case searchStore(keyword: String, orderby: String) // 쿼리스트링
    case reviewedStores
    case myReviews
    case toggleWishList(storeId: String, isLike: Bool)
    
    // MARK: - BaseURL
    var baseURL: URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    // MARK: - EndPoint
    /// - note : 쿼리스트링 작성
    var endPoint: String {
        switch self {
        case .rank:
            return "stores/rank"
        case .rankSample:
            return "stores/rank-sample"
        case .categorys:
            return "stores/category"
        case .getWishlist:
            return "stores/wishlist"
        case .storeDetail(let id):
            return "stores/\(id)"
        case .getImages(let id):
            return "reviews/images/\(id)"
        case .getReviews(let id, _, _, _):
            return "reviews/\(id)"
        case .createReview:
            return "reviews"
        case .deleteReview(let reviewid):
            return "reviews/\(reviewid)"
        case .updateReview(let id, _, _):
            return "reviews/\(id)"
        case .reviewLike(let reviewid, _):
            return "reviews/like/\(reviewid)"
        case .mapList:
            return "stores/map"
        case .mapStoreInfo(let storeid):
            return "stores/map/\(storeid)"
        case .recommendStore:
            return "stores/recommend"
        case .searchStore:
            return "stores/search"
        case .reviewedStores:
            return "stores/reviewed"
        case .myReviews:
            return "reviews/myReview"
        case .toggleWishList:
            return "stores/wishlist"
        default:
            return ""
        }
    }
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .rank:
            return .get
        case .rankSample:
            return .get
        case .categorys:
            return .get
        case .getWishlist:
            return .get
        case .storeDetail:
            return .get
        case .getImages:
            return .get
        case .getReviews:
            return .get
        case .createReview:
            return .post
        case .deleteReview:
            return .delete
        case .updateReview:
            return.put
        case .reviewLike:
            return .post
        case .mapList:
            return .post
        case .mapStoreInfo:
            return .get
        case .recommendStore:
            return .get
        case .searchStore:
            return .get
        case .reviewedStores:
            return .get
        case .myReviews:
            return .get
        case .toggleWishList:
            return .post
        default:
            return .head /// 헤드 리턴.
        }
    }
    // MARK: - Parameters
    
    var parameters: Parameters{
        switch self {
        case .categorys(let orderby):
            var params = Parameters()
            params["orderby"] = orderby
            return params
        case .getReviews(_ , let orderby, let page, let limit):
            var params = Parameters()
            params["orderby"] = orderby
            params["page"] = page
            params["limit"] = limit
            return params
        case .createReview(let dto, let images):
            var params = Parameters()
            params["dto"] = dto
            params["images"] = images
            return params
        case .updateReview(_ , let dto, let image):
            var params = Parameters()
            params["dto"] = dto
            params["image"] = image
            return params
        case .reviewLike(_ , let isLike):
            var params = Parameters()
            params["isLike"] = isLike
            return params
        case .mapList(let distance, let keyword, let category):
            var params = Parameters()
            params["distance"] = distance
            if let keywordData = keyword {
                params["keyword"] = keywordData
            }
            if let categoryData = category {
                params["category"] = categoryData
            }
            return params
        case .searchStore(let keyword, let orderby):
            var params = Parameters()
            params["keyword"] = keyword
            params["orderby"] = orderby
            return params
        case .toggleWishList(let storeId, let isLike):
            var params = Parameters()
            params["storeId"] = storeId
            params["isLike"] = isLike
            return params
            /// 파라미터 없을 경우
        default:
            var params = Parameters()
            return params
        }
    }
    
    // MARK: - asURLRequest()
    func asURLRequest() throws -> URLRequest {
        /// BaseURL에 EndPoint 추가
        let url = baseURL.appendingPathComponent(endPoint)
        
        /// 반환해줄 request
        var request = URLRequest(url: url)
        
        /// method 지정
        request.method = method
        
        switch self {
        /// - note : 단독
        case .updateReview(_, let dto, let image):
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            request = try! UpdateReviewFormDataStreamer(dto: dto, image: image).encode(request)
            return request
        /// form-data
        case .createReview(let dto, let images):
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            request = try! CreateReviewFormDataStreamer(dto: dto, images: images).encode(request)
            return request
        /// 쿼리 스트링
        case .categorys, .searchStore, .getReviews, .mapStoreInfo:
            request = try URLEncoding.queryString.encode(request, with: parameters)
            return request
        /// access토큰만 필요한 경우
        case .getWishlist, .storeDetail, .reviewedStores, .myReviews, .rankSample, .rank, .deleteReview, .getImages, .recommendStore:
            return request
        default:
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
            return request
        }
    }
}
