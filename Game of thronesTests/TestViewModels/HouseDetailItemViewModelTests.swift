//
//  HouseDetailItemViewModelTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseDetailItemViewModelTests: XCTestCase {

    var houseDetailItemViewModel: HouseDetailItemViewModel!
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    }
    
    /// Ensure that HouseDetailItemViewModel returns the correct value for 'Title' property
    func test_should_return_correct_title() {
        let houseDetailItem = HouseDetailItem(title: "Name", value: "King Kuda")
        let houseDetailItemViewModel = HouseDetailItemViewModel(houseDetailItem)
        XCTAssertEqual(houseDetailItemViewModel.title, "Name")
    }
    
    /// Ensure that HouseDetailItemViewModel returns the correct value for 'Value' property
    func test_should_return_correct_value() {
        let houseDetailItem = HouseDetailItem(title: "Name", value: "King Kuda")
        let houseDetailItemViewModel = HouseDetailItemViewModel(houseDetailItem)
        XCTAssertEqual(houseDetailItemViewModel.value, "King Kuda")
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
