//
//  Constants.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import Foundation

/**
 프로젝트에서 사용하는 상수 데이터 관리
 - AllList : 전체 목록 화면
 - Add : 할 일 추가 화면
 */
enum Constants {
    enum AllList {
        static let title = "전체"
    }
    
    enum Add: CaseIterable {
        static let title = "새로운 할 일"
        static let sectionTitles = ["마감일", "태그", "우선순위", "이미지 추가"]
        static let placeholder = ["제목을 입력해 주세요.", "내용을 입력해 주세요."]
    }
    
    static let add = "추가"
    static let cancel = "취소"
}
