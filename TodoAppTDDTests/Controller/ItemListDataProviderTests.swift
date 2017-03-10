//
//  ItemListDataProviderTests.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/10/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest

@testable import TodoAppTDD

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_numberOfSections_isTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_numberOfRows_inFirstSection_isToDoCount() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(TodoItem(title: "Bar"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_numberOfRows_inSecondSection_isToDoneCount() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        sut.itemManager?.add(TodoItem(title: "Bar"))
        sut.itemManager?.checkItem(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func test_cellForRow_returnsItemCell() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_cellForRow_dequeueCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(TodoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_cellForRow_CallsConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let item = TodoItem(title: "Foo")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, item)
    }
    
    func test_cellForRow_inSectionTwo_callsConfigCellWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let item1 = TodoItem(title: "Foo")
        sut.itemManager?.add(item1)
        
        let item2 = TodoItem(title: "Bar")
        sut.itemManager?.add(item2)
        
        sut.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, item2)
    }
    
    func test_deleteButton_inFirstSection_showTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_deleteButton_inSecondSection_showTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func test_checkingAnItem_checksItInTheItemManager() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.todoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func test_uncheckingAnItem_unchecksItInTheItemManager() {
        sut.itemManager?.add(TodoItem(title: "First"))
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.todoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
}

extension ItemListDataProviderTests {
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView( withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            
            let mockTableView = MockTableView(frame:
                CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
            
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
    }
    
    class MockItemCell: ItemCell {
        var catchedItem: TodoItem?
        
        override func configCell(with item: TodoItem, checked: Bool = false) {
            catchedItem = item
        }
    }
}
