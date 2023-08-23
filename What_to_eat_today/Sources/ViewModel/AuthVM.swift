//
//  AuthVM.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/11.
//

import Combine
import SwiftUI

class AuthVM: ObservableObject {
    //MARK: properties
    var subscription = Set<AnyCancellable>()
    
    /// 이메일 전송 성공,실패시 호출
    let emailSendSuccess = PassthroughSubject<Void, Never>()
    let emailSendError = PassthroughSubject<String, Never>()
    
    /// 인증번호 성공,실패시 호출
    let codeSuccess = PassthroughSubject<Void, Never>()
    let codeError = PassthroughSubject<String, Never>()
    
    /// 검증 성공, 실패시 호출
    let ValidateSuccess = PassthroughSubject<Void, Never>()
    let ValidateError = PassthroughSubject<String, Never>()
    
    /// 로그인 성공, 실패시 호출
    let loginError = PassthroughSubject<String, Never>()
    let loginSuccess = PassthroughSubject<Void, Never>()
    let registerTokenSuccess = PassthroughSubject<Void, Never>()
    
    /// 회원가입 성공, 실패시 호출
    let registerSuccess = PassthroughSubject<Void, Never>()
    let registerError = PassthroughSubject<String, Never>()
    
    /// 로그아웃, 회원탈퇴 성공 실패시 호출
    let taskSuccess = PassthroughSubject<Void, Never>()
    let taskError = PassthroughSubject<String, Never>()
    
    /// 로그인 및 소셜 로그인 시  호출
    var jwtTokenUpdated = PassthroughSubject<JWTToken, Never>()
    var registerTokenUpdated = PassthroughSubject<String?, Never>()
    
    /// 로그아웃, 탈퇴 여부 수신
//    var logoutSend = PassthroughSubject<Void, Never>()
//    var deleteSend = PassthroughSubject<Void, Never>()
    
    @Published var logoutSend : Bool = false
    @Published var deleteSend : Bool = false
    
    /// - note : 응답 데이터
    @Published var LoginToken : LoginResponse? = nil
    @Published var universityResponse: [University] = [] /// 대학교 Published
    
    /// (학교)이메일 전송 [POST]
    func sendEmail(email: String) {
        print("AuthVM: sendEmail() called")
        AuthApiService.emailSend(email: email)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 여기서 에러 메시지를 표시하거나 처리
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.emailSendError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                // 이메일 전송이 성공했다면, 이 부분에서 후속 조치. 예를 들어 다음 화면으로 이동
                if isSuccess {
                    self.emailSendSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    /// 이메일 인증 (로그인 상태일 때) [POST]
    func emailAuthLogin(email: String, authNum: String) {
        print("AuthVM: emailAuthLogin() called")
        AuthApiService.emailAuthLogin(email: email, authNum: authNum)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 여기서 에러 메시지를 표시하거나 처리
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.codeError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                // 이메일 전송이 성공했다면, 이 부분에서 후속 조치. 예를 들어 다음 화면으로 이동
                if isSuccess {
                    self.codeSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    /// 이메일 인증 (회원가입 할 때) [POST]
    func emailAuthRegister(email: String, authNum: String) {
        print("AuthVM: emailAuthRegister() called")
        AuthApiService.emailAuthRegister(email: email, authNum: authNum)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 여기서 에러 메시지를 표시하거나 처리
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.codeError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                // 이메일 전송이 성공했다면, 이 부분에서 후속 조치. 예를 들어 다음 화면으로 이동
                if isSuccess {
                    self.codeSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    ///emailValidate - 이메일 유효성 검사[POST]
    func emailValidate(email: String) {
        print("AuthVM: emailValidate() called")
        AuthApiService.emailValidate(email: email)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 여기서 에러 메시지를 표시하거나 처리
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.ValidateError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                // 이메일 전송이 성공했다면, 이 부분에서 후속 조치. 예를 들어 다음 화면으로 이동
                if isSuccess {
                    self.ValidateSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    ///nickNameValidate - 닉네임 유효성 검사[POST]
    func nickNameValidate(nickname: String) {
        print("AuthVM: nickNameValidate() called")
        AuthApiService.nickNameValidate(nickname: nickname)
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 여기서 에러 메시지를 표시하거나 처리
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.ValidateError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                // 이메일 전송이 성공했다면, 이 부분에서 후속 조치. 예를 들어 다음 화면으로 이동
                if isSuccess {
                    self.ValidateSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    ///register 회원가입 [POST] (O)
    func register(dto: RegisterRequest, image: UIImage? = nil) {
        var social: Bool = false
        
        print("AuthVM: register() called")
        AuthApiService.register(dto: dto, image: image)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.registerError.send(error.localizedDescription)
                }
            }, receiveValue: { registerResponse in
                if(dto.registerAccessToken != nil ) { social = true }
                UserDefaultsManager.shared.setTokens(accessToken: registerResponse.accessToken,
                                                 refreshToken: registerResponse.refreshToken,
                                                 social: social)
                self.registerSuccess.send()
            })
            .store(in: &subscription)
    }
    
    /// 로그인 [POST] (O)
    func login(email: String, password: String){
        print("UserVM: login() called")
        AuthApiService.Login(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self.loginError.send(error.localizedDescription)
                }
            } receiveValue: { loginToken in
                UserDefaultsManager.shared.setTokens(accessToken: loginToken.accessToken,
                                                 refreshToken: loginToken.refreshToken,
                                                social: false)
                self.loginSuccess.send()
            }
            .store(in: &subscription)
    }
    
    /// 카카오 로그인 [POST]
    func kakaoLogin(kakaoAccessToken: String) {
        print("AuthVM: kakaoLogin() called")
        AuthApiService.kakaoLogin(kakaoAccessToken: kakaoAccessToken)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self.loginError.send(error.localizedDescription)
                }
            } receiveValue: { socialToken in
                if (socialToken.result.registerAccessToken != nil) {
                    self.registerTokenUpdated.send(socialToken.result.registerAccessToken)
                    self.registerTokenSuccess.send()
                }
                if (socialToken.result.accessToken != nil && socialToken.result.refreshToken != nil) {
                    UserDefaultsManager.shared.setTokens(accessToken: socialToken.result.accessToken!,
                                                         refreshToken: socialToken.result.refreshToken!,
                                                        social: true)
                    self.jwtTokenUpdated.send(JWTToken(accessToken: socialToken.result.accessToken ?? "",
                                                    refreshToken: socialToken.result.refreshToken ?? ""))
                    self.loginSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    /// 애플 로그인 [POST]
    func appleLogin(code: String, idToken: String) {
        print("AuthVM: appleLogin() called")
        
        AuthApiService.appleLogin(code: code, idToken: idToken)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self.loginError.send(error.localizedDescription)
                }
            } receiveValue: { socialToken in
                if (socialToken.result.registerAccessToken != nil) {
                    self.registerTokenUpdated.send(socialToken.result.registerAccessToken)
                    self.registerTokenSuccess.send()
                }
                if (socialToken.result.accessToken != nil && socialToken.result.refreshToken != nil) {
                    UserDefaultsManager.shared.setTokens(accessToken: socialToken.result.accessToken!,
                                                         refreshToken: socialToken.result.refreshToken!,
                                                        social: true)
                    self.jwtTokenUpdated.send(JWTToken(accessToken: socialToken.result.accessToken ?? "",
                                                    refreshToken: socialToken.result.refreshToken ?? ""))
                    self.loginSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    /// searchUniversity 대학교 검색 [GET] (쿼리 스트링)
    func searchUniversity(keyword: String) {
        print("AuthVM: searchUniversity() called")
        
        AuthApiService.searchUniversity(keyword: keyword)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM searchUniversity: \(error)")
                }
            } receiveValue: { universities in // 변경 사항
                self.universityResponse = universities // 변경 사항
            }
            .store(in: &subscription)
    }
    
    /// 로그아웃 [POST]
    func logout() {
        print("AuthVM: logout() called")
        AuthApiService.logout()
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    UserDefaultsManager.shared.clearAll()
//                    for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//                      print("\(key) = \(value) \n")
//                    }
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }
    
    /// 회원탈퇴 [POST]
    func deleteUser() {
        print("AuthVM: deleteUser() called")
        AuthApiService.deleteUser()
            .sink { [weak self] (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self?.taskError.send(error.localizedDescription)
                }
            } receiveValue: { (isSuccess: Bool) in
                if isSuccess {
                    UserDefaultsManager.shared.clearAll()
                    self.taskSuccess.send()
                }
            }
            .store(in: &subscription)
    }

    /// 비밀번호 초기화 [POST]
    func passwordReset(email: String) {
        print("UserVM: passwordReset() called")
        AuthApiService.passwordReset(email: email)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("AuthVM completion: 에러 발생 - 에러 메시지: \(error.localizedDescription)")
                    self.emailSendError.send(error.localizedDescription)
                }
            } receiveValue: { loginToken in
                
                self.emailSendSuccess.send()
            }
            .store(in: &subscription)
    }
}
