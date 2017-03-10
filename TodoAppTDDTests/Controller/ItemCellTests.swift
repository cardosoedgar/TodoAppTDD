//
//  ItemCellTests.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/10/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest

@testable import TodoAppTDD

class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    let datasource = FakeDataSource()
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView?.dataSource = datasource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_hasNameLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func test_hasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func test_hasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func test_configCell_setsLabelTexts() {
        let location = Location(name: "Bar")
        let item = TodoItem(title: "Foo",
                            description: nil,
                            timestamp: 1456150025,
                            location: location)
        
        cell.configCell(with: item)
        
        XCTAssertEqual(cell.titleLabel.text, "Foo")
        XCTAssertEqual(cell.locationLabel.text, "Bar")
        XCTAssertEqual(cell.dateLabel.text, "22/02/2016")
    }
    
    func test_title_whenItemIsChecked_isStrokeThrough() {
        let location = Location(name: "Bar")
        let item = TodoItem(title: "Foo",
                            description: nil,
                            timestamp: 1456150025,
                            location: location)
        
        cell.configCell(with: item, checked: true)
        
        let attributedString = NSAttributedString(
            string: "Foo",
            attributes: [NSStrikethroughStyleAttributeName:
                NSUnderlineStyle.styleSingle.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
