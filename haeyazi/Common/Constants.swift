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
    enum Title {
        static let all = "전체"
    }
    
    enum Main {
        static let titles = ["오늘", "예정", "전체", "깃발 표시", "완료됨"]
    }
    
    enum Add: CaseIterable {
        static let title = "새로운 할 일"
        static let sectionTitles = ["마감일", "태그", "우선순위", "이미지 추가"]
        static let placeholders = ["제목을 입력해 주세요.", "내용을 입력해 주세요."]
        static let priority =  ["높아요", "보통이에요", "낮아요"]
    }
    
    
    static let add = "추가"
    static let cancel = "취소"
}
