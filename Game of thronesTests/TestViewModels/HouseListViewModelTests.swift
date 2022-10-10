//
//  HouseListViewModelTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseListViewModelTests: XCTestCase {
    
    var houseListViewModel: HouseListViewModel!
    var webService: WebServiceProtocol?

    override func setUpWithError() throws {
        
        houseListViewModel = HouseListViewModel()
        webService = WebServiceMock(shouldReturnError: false)
        houseListViewModel.webService = webService
        houseListViewModel.fetchHouses(pageNumber: 1)
        
    }

    override func tearDownWithError() throws {
        houseListViewModel = nil
        webService = nil
    }
    
    /// Ensure that HouseListViewModel returns 2 sections
    func testNumber_Of_sections_should_return_2() {
        XCTAssertEqual(houseListViewModel.numberOfSections, 2)
    }
    
    /// Ensure that HouseListViewModel returns the correct number of rows for a given section
    func test_should_return_correct_number_of_rows_in_section() {
        XCTAssertEqual(houseListViewModel.numberOfRowsInSection(0), 2)
    }
    
    /// Ensure that HouseListViewModel returns the correct HouseViewModel object with the correct data  for a given index
    func test_should_return_correct_house_at_index() {
        let houseAtIndex = houseListViewModel.houseAtIndex(0)
        XCTAssertEqual(houseAtIndex.name, houseListViewModel.houses[0].name)
        XCTAssertEqual(houseAtIndex.region, houseListViewModel.houses[0].region)
    }
    

}
