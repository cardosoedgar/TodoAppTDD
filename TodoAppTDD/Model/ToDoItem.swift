//
//  ToDoItem.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/9/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

struct TodoItem: Equatable {
    let title: String
    let description: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, description: String? = nil,
         timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.timestamp = timestamp
        self.location = location
    }
    
    static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
        if lhs.location != rhs.location {
            return false
        }
        
        if lhs.timestamp != rhs.timestamp {
            return false
        }
        
        if lhs.description != rhs.description {
            return false
        }
        
        if lhs.title != rhs.title {
            return false
        }
        
        return true
    }
}
