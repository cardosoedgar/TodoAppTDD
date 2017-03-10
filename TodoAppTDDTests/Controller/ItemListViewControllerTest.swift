//
//  ItemListViewControllerTest.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/10/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest

@testable import TodoAppTDD

class ItemListViewControllerTest: XCTestCase {
    
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        
        sut = viewController as! ItemListViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_tableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_loadingView_setsTableViewDatasource() {
        XCTAssertNotNil(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    func test_loadingView_setsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    func test_loadingView_setsDatasourceAndDelegateToSameObject() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider,
                       sut.tableView.delegate as? ItemListDataProvider)
    }
}
