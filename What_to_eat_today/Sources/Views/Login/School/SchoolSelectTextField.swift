//
//  SchoolSelectView.swift
//  What_to_eat_today
//
//  Created by 백대홍 on 2023/07/14.
//

import SwiftUI
import Combine

struct SchoolSelectTextField: View {
    @StateObject private var authVM = AuthVM()
    @Binding var registerData: RegisterRequest
    
    @StateObject private var searchTermManager = TextBindingManager(text: "")
    private var searchTerm: String {
        searchTermManager.text
    }
    @Binding var isTextFieldEmpty: Bool
    @State private var showScrollView: Bool = false
    @State private var selectedUniversity: University?
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            TextField("대학교를 입력해주세요.", text: $searchTermManager.text)
                .onChange(of: searchTerm) { _ in
                                 showScrollView = true
                                 selectedUniversity = nil
                                 // 추가: 텍스트 변경 알림
                                 isTextFieldEmpty = searchTerm.isEmpty
                             }
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
                .padding(.horizontal, 5)
                .padding(.vertical, 0)
                .padding(.bottom, 0)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .inset(by: 0.5)
                        .stroke(Color.GrayScale300, lineWidth: 1)
                )
                .textInputAutocapitalization(.never)
            
            if showScrollView {
                ScrollView {
                    ForEach(authVM.universityResponse.filter { university in
                        return university.universityName.lowercased().contains(searchTerm.lowercased())
                    }) { university in
                        Button(action: {
                            self.selectedUniversity = university
                            showScrollView = false
                        }) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(university.universityName)
                                    .foregroundColor(.GrayScale800)
                                    .font(.headline)
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .overlay(
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.GrayScale100, lineWidth: 1)
                            )
                        }
                    }
                }
                .foregroundColor(.GrayScale100)
                .cornerRadius(8)
            }
            
            if let selectedUniversity = selectedUniversity {
                ScrollView {
                    VStack {
                        ForEach(selectedUniversity.campers) { camper in
                            Button(action: {
                                searchTermManager.text = selectedUniversity.universityName + " " + camper.campersName
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                                to: nil,
                                                                from: nil,
                                                                for: nil)
                                registerData.campersId = camper.id
                                self.selectedUniversity = nil
                            })
                            {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(selectedUniversity.universityName + " " + camper.campersName)
                                        .foregroundColor(.GrayScale800)
                                        .font(.headline)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color.GrayScale100, lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                .foregroundColor(.GrayScale100)
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .onAppear {///화면 로드시 데이터 불러오기
            authVM.searchUniversity(keyword: "")
        }
    }
}


extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

final class TextBindingManager: ObservableObject {
    @Published public var text = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(text: String) {
        _text = Published(initialValue: text)
        $text
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.objectWillChange.send()
                }
            }
            .store(in: &subscriptions)
    }
}

//struct SchoolSelectTextField_Previews: PreviewProvider {
//    @State static var test = RegisterRequest.init()
//    static var previews: some View {
//        SchoolSelectTextField(registerData: $test)
//    }
//}
