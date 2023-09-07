//
//  StoreVM.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/21.
//

import SwiftUI
import Combine

class StoreVM: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    let taskSuccess = PassthroughSubject<Void, Never>()
    let taskError = PassthroughSubject<String, Never>()
    
    let filterButtonTapped = PassthroughSubject<Void, Never>()
    
    let storeInfoSuccess = PassthroughSubject<Void, Never>()
    @Published var categoryData: CategoryResponse = .init(한식: [], 중식: [], 양식: [], 일식: [], 분식: [], 아시아: [], 패스트푸드: [], 레스토랑: [],                                                카페: [], 술집: [])
    @Published var wishListStatus: [String: Bool] = [:]
    @Published var wishlistData: [Restaurant] = []
    @Published var recommendData: [RecommendStore] = []
    @Published var searchStoreData: [RecommendStore] = []
    @Published var mapListData: MapListResponse = .init(campers: .init(x: 35, y: 129), stores: [])
    @Published var mapStoreInfoData: Restaurant = .init(storeId: "", name: "", category: "", rank: [], score: 0.0, status: nil, reviewCount: 0, time: "", imageUrl: "", reviewImage: nil, reviewContent: nil, isWishlist: nil)
    @Published var storeDetailData: StoreDetailResponse = .init(storeName: "", category: "", imageUrl: nil, keywords: [], tags: [:], status: nil, phoneNumber: nil, address: "", time: "", imageCount: 0, x: 0.0, y: 0.0)
    @Published var reviewStoreData: ReviewedStoresResponse = .init()
    @Published var myReviewsData: MyReviewsResponse = .init()
    @Published var rankSampleData: RankSampleResponse = .init(밥약: [], 가성비: [], 혼밥: [], 단체: [], 술약속: [])
    @Published var rankData: RankingResponse = .init(밥약: [], 가성비: [], 혼밥: [], 단체: [], 술약속: [])
    @Published var getReviewData: getReviewResponse = .init()
    @Published var getImagesData: [String] = []
    
    var categorys: [Restaurant] {
        var categorys: [Restaurant] = []

        if let 한식 = categoryData.한식 {
            categorys.append(contentsOf: 한식.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "한식", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }
       
        if let 중식 = categoryData.중식 {
            categorys.append(contentsOf: 중식.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "중식", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }
       
        if let 일식 = categoryData.일식 {
            categorys.append(contentsOf: 일식.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "일식", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 양식 = categoryData.양식 {
            categorys.append(contentsOf: 양식.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "양식", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 분식 = categoryData.분식 {
            categorys.append(contentsOf: 분식.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "분식", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 아시아 = categoryData.아시아 {
            categorys.append(contentsOf: 아시아.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "아시아", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 레스토랑 = categoryData.레스토랑 {
            categorys.append(contentsOf: 레스토랑.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "레스토랑", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 패스트푸드 = categoryData.패스트푸드 {
            categorys.append(contentsOf: 패스트푸드.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "패스트푸드", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 카페 = categoryData.카페 {
            categorys.append(contentsOf: 카페.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "카페", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        if let 술집 = categoryData.술집 {
            categorys.append(contentsOf: 술집.map { Restaurant(storeId: $0.storeId, name: $0.name, category: "술집", rank: $0.rank, score: $0.score, status: $0.status, reviewCount: $0.reviewCount, time: $0.time, imageUrl: $0.imageUrl, reviewImage: $0.reviewImage, reviewContent: $0.reviewContent, isWishlist: $0.isWishlist) })
        }

        return categorys
    }

    //case rank
    func rank() {
        print("StoreVM: rank() called")
        
        StoreApiService.rank()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: rank() \(error)")
                }
            } receiveValue: { rankData in
                self.rankData = rankData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    
    //case rankSample
    func rankSample() {
        print("StoreVM: rankSample() called")
        
        StoreApiService.rankSample()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: rankSample() \(error)")
                }
            } receiveValue: { rankSampleData in
                self.rankSampleData = rankSampleData
            }
            .store(in: &subscription)
    }
    
    //case categorys(orderby: String) ///쿼리 스트링
    func categorys(orderby: String) {
        print("StoreVM: categorys() called")
        
        StoreApiService.categorys(orderby: orderby)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: categorys() \(error)")
                }
            } receiveValue: { categoryData in
                self.categoryData = categoryData
            }
            .store(in: &subscription)
    }
    
    //case getWishlist
    func getWishlist() {
        print("StoreVM: getWishlist() called")
        
        StoreApiService.getWishlist()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: getWishlist() \(error)")
                }
            } receiveValue: { wishlistData in
                self.wishlistData = wishlistData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    //case storeDetail(id: String)///패스 스트링
    func storeDetail(id: String) {
        print("StoreVM: storeDetail() called")
        
        StoreApiService.storeDetail(id: id)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: storeDetail() \(error)")
                }
            } receiveValue: { storeDetailData in
                self.storeDetailData = storeDetailData
                self.storeInfoSuccess.send()
            }
            .store(in: &subscription)
    }
    
    //case getImages(id: String) ///패스 스트링
    func getImages(id: String) {
        print("StoreVM: getImages() called")
        
        StoreApiService.getImages(id: id)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: getImages() \(error)")
                }
            } receiveValue: { getImagesData in
                self.getImagesData = getImagesData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    
    //case getReviews(id: String, orderby: String, page: Int, limit: Int) ///패스 스트링, 쿼리 스트링
    func getReviews(id: String, orderby: String, page: Int, limit: Int) {
        print("StoreVM: getReviews() called")
        
        StoreApiService.getReviews(id: id, orderby: orderby, page: page, limit: limit)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM getReviews() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { getReviewData in
                self.getReviewData = getReviewData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    //case createReview(dto: CreateReviewRequest, image: UIImage?)///form-data
    func createReview(dto: CreateReviewRequest, images: UIImage? = nil) {
        print("StoreVM: createReview() called")
        
        StoreApiService.createReview(dto: dto, images: images)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.taskError.send(error.localizedDescription)
                }
            }, receiveValue: { id in
                print("테스트:\(id)")
                self.taskSuccess.send()
            })
            .store(in: &subscription)
    }
    //위시리스트가 각요소에 맞게끔 독립
    func toggleWishList(storeId: String) {
        // 위시리스트 상태 토글
        let currentStatus = wishListStatus[storeId] ?? false
        wishListStatus[storeId] = !currentStatus

        // 서버로 업데이트
        StoreApiService.toggleWishList(storeId: storeId, isLike: !currentStatus)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM toggleWishList() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }

    
    //case deleteReview(reviewid: String)///패스 스트링
    func deleteReview(reviewid: String) {
        print("StoreVM: deleteReview() called")
        StoreApiService.deleteReview(reviewid: reviewid)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM deleteReview() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    //case updateReview(id: Int, dto: UpdateReviewRequest, image: UIImage?)///form-data, 패스스트링
    //case reviewLike(reviewid: Int, isLike: Bool)///패스 스트링, json
    //case .mapList(let distance, let keyword, let category)
    func mapList(distance: Int, keyword: [String]? = nil, category: [String]? = nil) {
        print("StoreVM: mapList() called")
        
        StoreApiService.mapList(distance: distance, keyword: keyword, category: category)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: mapList() \(error)")
                }
            } receiveValue: { mapListData in
                self.mapListData = mapListData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    //case mapStoreInfo(storeid: String)///패스 스트링
    func mapStoreInfo(storeid: String) {
        print("StoreVM: mapStoreInfo() called")
        
        StoreApiService.mapStoreInfo(storeid: storeid)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: mapList() \(error)")
                }
            } receiveValue: { mapStoreInfoData in
                self.mapStoreInfoData = mapStoreInfoData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    //case recommendStore
    func recommendStore() {
        print("StoreVM: recommendStore() called")
        
        StoreApiService.recommendStore()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: recommendStore() \(error)")
                }
            } receiveValue: { recommendData in
                self.recommendData = recommendData
            }
            .store(in: &subscription)
    }
    
    //case searchStore(keyword: String, orderby: String) // 쿼리스트링
    func searchStore(keyword: String, orderby: String) {
        print("StoreVM: searchStore() called")
        
        StoreApiService.searchStore(keyword: keyword, orderby: orderby)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: searchStore() \(error)")
                }
            } receiveValue: { searchStoreData in
                self.searchStoreData = searchStoreData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    
    //case reviewedStores
    func reviewedStores() {
        print("StoreVM: reviewedStores() called")
        
        StoreApiService.reviewedStores()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: reviewedStores() \(error)")
                }
            } receiveValue: { reviewStoreData in
                self.reviewStoreData = reviewStoreData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    //case myReviews
    func myReviews() {
        print("StoreVM: myReviews() called")
        
        StoreApiService.myReviews()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM: myReviews() \(error)")
                }
            } receiveValue: { myReviewsData in
                self.myReviewsData = myReviewsData
                self.taskSuccess.send()
            }
            .store(in: &subscription)
    }
    
    //case toggleWishList(storeId: String, isLike: Bool)
    func toggleWishList(storeId: String, isLike: Bool) {
        print("StoreVM: toggleWishList() called")
        StoreApiService.toggleWishList(storeId: storeId, isLike: isLike)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("StoreVM toggleWishList() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
}
