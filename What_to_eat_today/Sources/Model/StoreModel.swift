

import Foundation

// json을 위한 Codable
// 고유 개체 구분 Identifiable
struct Store: Codable, Identifiable {
    let id: String
    let name: String
    let address: String
    let phoneNumber: String
    let ranking: String
    let openTime: Date
    let closeTime: Date
    let star: Double
    let reviewCnt: Int
    let coordinateX: Double
    let coordinateY: Double
    let distanceType: Int
    let imageURL: String
    let mainKeyword: String
    let storedistance: String
    let heart: Bool
    let storestatus: Bool
    
    
    static func specificTime(hour: Int, minute: Int) -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let calendar = Calendar.current
        return calendar.date(from: dateComponents) ?? Date()
    }
}

struct Stores {
    var stores: [Store]
    
    init() {
        stores = [
            Store(id: "1",
                  name: "가게1",
                  address: "주소1",
                  phoneNumber: "010-1111-1111",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 8, minute: 0),
                  closeTime: Store.specificTime(hour: 17, minute: 0),
                  star: 4.5,
                  reviewCnt: 10,
                  coordinateX: 37.12345,
                  coordinateY: 126.98765,
                  distanceType: 5,
                  imageURL: "Store-image1",
                  mainKeyword: "한식",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게2",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "일식",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게3",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "양식",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            Store(id: "2",
                  name: "가게4",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게5",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게6",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게7",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게8",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게10",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            Store(id: "2",
                  name: "가게11",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            Store(id: "2",
                  name: "가게12",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            Store(id: "2",
                  name: "가게13",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            
            Store(id: "2",
                  name: "가게14",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            
            Store(id: "2",
                  name: "가게15",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true),
            
            
            
            Store(id: "2",
                  name: "가게16",
                  address: "주소2",
                  phoneNumber: "010-2222-2222",
                  ranking: "1등",
                  openTime: Store.specificTime(hour: 10, minute: 0),
                  closeTime: Store.specificTime(hour: 20, minute: 0),
                  star: 3.0,
                  reviewCnt: 30,
                  coordinateX: 37.54321,
                  coordinateY: 126.12345,
                  distanceType: 10,
                  imageURL: "Store-image2",
                  mainKeyword: "키워드2",
                  storedistance: "걸어서 5분",
                  heart: true,
                  storestatus: true)
            
            
            
        ]
    }
}
