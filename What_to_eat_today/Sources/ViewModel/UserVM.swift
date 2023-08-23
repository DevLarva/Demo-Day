//
//  UserVM.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/20.
//

import SwiftUI
import Combine

class UserVM: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    let changeSuccess = PassthroughSubject<Void, Never>()
    let changeError = PassthroughSubject<String, Never>()
    
    let taskSuccess = PassthroughSubject<Void, Never>()
    let taskError = PassthroughSubject<String, Never>()
    
    let infoSuccess = PassthroughSubject<Void, Never>()
    @Published var userInfoData: User = User(id: "", nickname: "", imageURL: "", campers: nil, isEmailAuth: 0)
    @Published var userDetailInfoData: UserDetailInfoResponse.User = UserDetailInfoResponse.User(id: "", name: "", nickname: "", email: "", universityEmail: nil, imageURL: nil, campers: nil, isEmailAuth: 0, agreement: false)
    
    func userInfo() {
        print("UserVM: userInfo() called")
        
        UserApiService.userInfo()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM: userInfo() \(error)")
                }
            } receiveValue: { userInfoData in
                self.userInfoData = userInfoData.user
                self.infoSuccess.send()
            }
            .store(in: &subscription)
    }
    
    func userDetail() {
        print("UserVM: userDetail() called")
        
        UserApiService.userDetail()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM: userDetail() \(error)")
                }
            } receiveValue: { userDetailInfoData in
                self.userDetailInfoData = userDetailInfoData.user
            }
            .store(in: &subscription)
    }
    
    func nickNameChange(nickname: String) {
        print("UserVM: nickNameChange() called")
        
        UserApiService.nickNameChange(nickname: nickname)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM nickNameChange() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.changeError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.changeSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    func emailChange(email: String) {
        print("UserVM: emailChange() called")
        
        UserApiService.emailChange(email: email)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM emailChange() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    func passwordChange(oldPassword: String, newPassword: String) {
        print("UserVM: passwordChange() called")
        
        UserApiService.passwordChange(oldPassword: oldPassword, newPassword: newPassword)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM passwordChange() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    func marketing(isAgree: String) {
        print("UserVM: marketing() called")
        
        UserApiService.marketing(isAgree: isAgree)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("UserVM marketing() completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
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

//    case userInfo
//    case userDetail
//    case nickNameChange(nickname: String)
//    case emailChange(email: String)
//    case passwordChange(oldPassword: String, newPassword: String)
//    case profileImageChange(image: UIImage)
//    case allInquery(wating: String) ///쿼리 파라미터
//    case inqueryDetail(id: String) ///쿼리 파라미터
//    case inqueryWrite(dto: InquiryResponse, images: UIImage?)///form-data
//    case inqueryResponse(id: String, content: String)///id는 쿼리 파라미터
//    case notice(type: String)///쿼리 파라미터
//    case fAQ(type: String)///쿼리 파라미터
//    case terms(type: String)///쿼리 파라미터
//    case marketing(isAgree: String)//쿼리 파라미터
