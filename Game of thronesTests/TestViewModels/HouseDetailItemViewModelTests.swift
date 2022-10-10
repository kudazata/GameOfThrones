//
//  HouseDetailItemViewModelTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseDetailItemViewModelTests: XCTestCase {

    var houseDetailItem: HouseDetailItem!
    var sut: HouseDetailItemViewModel!
    
    override func setUpWithError() throws {
        houseDetailItem = HouseDetailItem(title: "Name", value: "King Kuda")
        sut = HouseDetailItemViewModel(houseDetailItem)
    }

    override func tearDownWithError() throws {
        houseDetailItem = nil
        sut = nil
    }
    
    /// Ensure that HouseDetailItemViewModel returns the correct value for 'Title' property
    func test_should_return_correct_title() {
        XCTAssertEqual(sut.title, "Name")
    }
    
    /// Ensure that HouseDetailItemViewModel returns the correct value for 'Value' property
    func test_should_return_correct_value() {
        XCTAssertEqual(sut.value, "King Kuda")
    }


}
