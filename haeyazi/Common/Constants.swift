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
        static let navigationTitle = "새로운 할 일"
        static let title = "제목"
        static let memo = "메모"
        static let sectionTitles = ["마감일", "태그", "우선순위", "이미지 추가"]
        static let placeholders = ["제목을 입력해 주세요.", "메모를 입력해 주세요."]
        static let priority =  ["높아요", "보통이에요", "낮아요"]
    }
    
    enum Tag {
        static let tag = "태그"
        static let placeholder = "태그를 입력해 주세요."
        
    }
    
    enum AllList {
        enum Sort {
            static let title = "제목순"
            static let date = "마감일순"
            static let priority = "우선순위 높은순"
        }
    }
    
    enum Detail {
        static let navigationTitle = "상세정보"
    }
    
    enum Button {
        static let add = "추가"
        static let delete = "삭제"
        static let edit = "수정"
        static let okay = "확인"
        static let cancel = "취소"
        static let complete = "완료"
        static let new = "새로운 할 일"
        static let list = "목록 추가"
        static let incomplete = "미완료"
    }
    
    enum Alert {
        
    }
    
}
