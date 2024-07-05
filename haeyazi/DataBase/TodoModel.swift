//
//  TodoModel.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String        // 제목 (필수*)
    @Persisted var memo: String?        // 메모 (옵션)
    @Persisted var regDate: Date        // 생성일 (필수*)
    @Persisted var endDate: Date?       // 마감일 (옵션)
    @Persisted var tag: String?         // 태그 (옵션)
    @Persisted var priority: Int?       // 우선순위 (필수*)
    @Persisted var isDone: Bool         // 완료 여부 (필수*)
    
    convenience init(title: String, memo: String? = nil, endDate: Date? = nil, tag: String? = nil, priority: Int = 1) {
        self.init()
        self.title = title
        self.memo = memo
        self.regDate = Date()
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.isDone = false
    }
}
 
