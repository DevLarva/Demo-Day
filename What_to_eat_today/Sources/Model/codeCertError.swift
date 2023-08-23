//
//  codeCertError.swift
//  What_to_eat_today
//
//  Created by 준호 on 2023/08/12.
//

import Foundation

// 인증번호가 오류 발생할 경우
enum codeCertError {
    case none      /// 에러없음
    case timeOver  /// 시간초과
    case notCorrect/// 인증번호 틀림
}
