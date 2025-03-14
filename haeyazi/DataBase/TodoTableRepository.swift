//
//  TodoTableRepository.swift
//  haeyazi
//
//  Created by junehee on 7/5/24.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    
    private let realm = try! Realm()
    
    // create (할 일 생성)
    func createTodo(_ data: Todo) {
        do {
            try realm.write {
                realm.add(data)
                print(#function, "할 일 생성 완료")
                print(realm.configuration.fileURL)
            }
        } catch {
            print(#function, "할 일 생성 실패", error)
        }
    }
    
    // read
    func getAllTodo() -> Results<Todo> {
        return realm.objects(Todo.self)
    }
    
    func getTodayTodo(sort: Bool) -> Results<Todo> {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
       
        if sort {
            return realm.objects(Todo.self).filter("endDate >= %@ AND endDate < %@", today, tomorrow)
        } else {
            return realm.objects(Todo.self).filter("endDate >= %@", tomorrow)
        }
    }
    
    func getPriorityTodo(priority: Int) -> Results<Todo> {
        return realm.objects(Todo.self).where { todo in
            todo.priority == priority
        }
    }
    
    func getCompleteTodo(status: Bool) -> Results<Todo> {
        return realm.objects(Todo.self).where { todo in
            todo.isDone == status
        }
    }
    
    func getSortedTodo(target: Results<Todo>, key: String, ascending: Bool) -> Results<Todo> {
        return target.sorted(byKeyPath: key, ascending: ascending)
    }
    
    // update (할 일 수정)
    
    // delete
    func deleteTodo(_ data: Todo) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    
    // 스키마 버전 확인
    func getSchemaVersion() {
        print(realm.configuration.schemaVersion)
    }
}
