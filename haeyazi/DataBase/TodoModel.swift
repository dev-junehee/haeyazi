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
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var regDate: Date
    
    convenience init(title: String, memo: String?, regDate: Date) {
        self.init()
        self.id = id
        self.title = title
        self.memo = memo
        self.regDate = regDate
    }
}
 
