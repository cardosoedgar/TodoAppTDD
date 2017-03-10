//
//  ItemManagerTests.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/9/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest

@testable import TodoAppTDD

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_todoCount_initially_isZero() {
        XCTAssertEqual(sut.todoCount, 0)
    }
    
    func test_doneCount_initially_isZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_addItem_increasesToDoCountToOne() {
        sut.add(TodoItem(title: ""))
        
        XCTAssertEqual(sut.todoCount, 1)
    }
    
    func test_itemAt_afterAddingAnItem_ReturnsThatItem() {
        let item = TodoItem(title: "Foo")
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_checkItemAt_ChangesCounts() {
        sut.add(TodoItem(title: ""))
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.todoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_checkItemAt_removesItFromTodoItems() {
        let first = TodoItem(title: "First")
        let second = TodoItem(title: "Second")
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Second")
    }
    
    func test_doneItemAt_returnsCheckedItem() {
        let item = TodoItem(title: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_removeAll_resultsInCountsBeZero() {
        sut.add(TodoItem(title: "Foo"))
        sut.add(TodoItem(title: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.doneCount, 1)
        XCTAssertEqual(sut.todoCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.doneCount, 0)
        XCTAssertEqual(sut.todoCount, 0)
    }
    
    func test_add_whenItemIsAlreadyAdded_doestNotIncreaseCount() {
        sut.add(TodoItem(title: "Foo"))
        sut.add(TodoItem(title: "Foo"))
        
        XCTAssertEqual(sut.todoCount, 1)
    }
}
