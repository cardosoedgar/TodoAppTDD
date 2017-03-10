//
//  ItemManager.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/9/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

class ItemManager {
    
    var todoCount: Int { return todoItems.count }
    var doneCount: Int { return doneItems.count }
    
    private var todoItems: [TodoItem] = []
    private var doneItems: [TodoItem] = []
    
    func add(_ item: TodoItem) {
        if !todoItems.contains(item) {
            todoItems.append(item)
        }
    }
    
    func item(at index: Int) -> TodoItem {
        return todoItems[index]
    }
    
    func checkItem(at index:Int) {
        let item = todoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        todoItems.append(item)
    }
    
    func doneItem(at index:Int) -> TodoItem {
        return doneItems[index]
    }
    
    func removeAll() {
        todoItems.removeAll()
        doneItems.removeAll()
    }
}
