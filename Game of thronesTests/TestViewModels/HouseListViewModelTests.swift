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

    override func setUpWithError() throws {
        
        houseListViewModel = HouseListViewModel()
        let house1 = House(url: "",
                           name: "Test House 1",
                           region: "The North",
                           coatOfArms: "A silver sword",
                           words: "No words",
                           titles: ["Lord", "King"],
                           seats: ["Godsgrace", ""],
                           currentLord: "Lord Bayley",
                           heir: "Lord Jeffery",
                           overlord: "House of commons",
                           founded: "1900",
                           founder: "Lord disick",
                           diedOut: "1920",
                           ancestralWeapons: ["Knife", "Gun"],
                           cadetBranches: ["", ""],
                           swornMembers: ["Ariana", "Caroline"])
        
        let house2 = House(url: "",
                           name: "Test House 2",
                           region: "Test region",
                           coatOfArms: "A golden wreath",
                           words: "No words",
                           titles: ["Lord", "King"],
                           seats: ["Godsgrace", ""],
                           currentLord: "Lord Bayley",
                           heir: "Lord Jeffery",
                           overlord: "House of commons",
                           founded: "1900",
                           founder: "Lord disick",
                           diedOut: "1920",
                           ancestralWeapons: ["Knife", "Gun"],
                           cadetBranches: ["", ""],
                           swornMembers: ["Ariana", "Caroline"])
        
        houseListViewModel.houses = [house1, house2]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        XCTAssertEqual(houseAtIndex.name, "Test House 1")
        XCTAssertEqual(houseAtIndex.region, "The North")
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
