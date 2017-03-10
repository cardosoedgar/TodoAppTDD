//
//  LocationTests.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/9/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import XCTest
import CoreLocation

@testable import TodoAppTDD

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init_whenGivenCoordinate_setsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_WhenGivenName_SetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    
    func test_equalLocations_areEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_locations_whenLongitudeDiffers_areNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo",
                                FirstLongLat: (0.0, 1.0), secondLongLat: (0.0, 0.0))
    }
    
    func test_locations_whenLatitudeDiffers_areNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo",
                                FirstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0))
    }
    
    func test_locations_whenLocationIsNilAndTheOtherIsnt_areNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo",
                                FirstLongLat: (1.0, 0.0), secondLongLat: nil)
    }
    
    func test_locations_whenNameDiffers_areNotEqual() {
        performNotEqualTestWith(firstName: "Foo", secondName: "Bar",
                                FirstLongLat: nil, secondLongLat: nil)
    }
    
    func performNotEqualTestWith(firstName: String, secondName: String, FirstLongLat: (Double, Double)?, secondLongLat: (Double,Double)?, line: UInt = #line) {
        
        var firstCoord: CLLocationCoordinate2D? = nil
        if let FirstLongLat = FirstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: FirstLongLat.0, longitude: FirstLongLat.1)
        }
        
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        }
        
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }
}







