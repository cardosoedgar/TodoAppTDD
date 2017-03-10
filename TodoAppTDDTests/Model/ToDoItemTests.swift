//
//  ToDoItemTests.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/8/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest

@testable import TodoAppTDD

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_whenGivenTitle_setsTitle() {
        let item = TodoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo", "should set Title")
    }
    
    func test_whenGivenDescription_setsDescription() {
        let item = TodoItem(title: "", description: "Bar")
        XCTAssertEqual(item.description, "Bar", "should set description")
    }
    
    func test_init_whenGivenTimestamp_setsTimestamp() {
        let item = TodoItem(title: "", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0, "should set timestamp")
    }
    
    func test_init_whenGivenLocation_setsLocation() {
        let location = Location(name: "foo")
        let item = TodoItem(title: "Foo", location: location)
        
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func text_equalItems_areEqual() {
        let first = TodoItem(title: "Foo")
        let second = TodoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_items_whenLocationDiffers_areNotEqual() {
        let first = TodoItem(title: "", location: Location(name: "Foo"))
        let second = TodoItem(title: "", location: Location(name: "Bar"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_items_whenLocationIsNilAndTheOtherIsnt_areNotEqual() {
        let first = TodoItem(title: "", location: Location(name: ""))
        let second = TodoItem(title: "")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_items_whenTimestampDiffers_areNotEqual() {
        let first = TodoItem(title: "Foo", timestamp: 1.0)
        let second = TodoItem(title: "Foo", timestamp: 0.0)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_items_whenDescriptionDiffers_areNotEqual() {
        let first = TodoItem(title: "Foo", description: "Bar")
        let second = TodoItem(title: "Foo", description: "Baz")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_items_whenTitleDiffers_areNotEqual() {
        let first = TodoItem(title: "Foo")
        let second = TodoItem(title: "Bar")
        
        XCTAssertNotEqual(first, second)
    }
}
