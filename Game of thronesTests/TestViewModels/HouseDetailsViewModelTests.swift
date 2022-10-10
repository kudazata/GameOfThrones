//
//  HouseDetailsViewModelTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseDetailsViewModelTests: XCTestCase {
    
    var house: House!
    var sut: HouseDetailsViewModel!

    override func setUpWithError() throws {
        
        house = House(url: "",
                      name: "Test House",
                      region: "Test region",
                      coatOfArms: "A golden wreath",
                      words: "No words",
                      titles: ["Lord Scott", "King Kuda"],
                      seats: ["Ashford"],
                      currentLord: "https://anapioficeandfire.com/api/characters/894",
                      heir: "https://anapioficeandfire.com/api/characters/477",
                      overlord: "https://anapioficeandfire.com/api/houses/7",
                      founded: "1900 BC",
                      founder: "https://anapioficeandfire.com/api/characters/144",
                      diedOut: "1920 AD",
                      ancestralWeapons: ["Sharp Knife", "big shotgun"],
                      cadetBranches: ["https://anapioficeandfire.com/api/houses/6", "https://anapioficeandfire.com/api/houses/8"],
                      swornMembers: ["https://anapioficeandfire.com/api/characters/298", "https://anapioficeandfire.com/api/characters/1301"])
        
        sut = HouseDetailsViewModel()
        sut.webService = WebServiceMock(shouldReturnError: false)
        sut.house = house
        sut.getHouseDetails()
    
    }

    override func tearDownWithError() throws {
        sut = nil
        
    }
    
    /// Ensure that HouseViewModel returns one section
    func testNumber_of_sections_should_Return_one() {
        XCTAssertEqual(sut.numberOfSections, 1)
    }
    
    /// Ensure that HouseViewModel returns the correct number of rows for a given section
    func test_should_return_correct_number_of_rows() {
        sut.populateHouseDetails()
        XCTAssertEqual(sut.numberOfRowsInSection(0), 15)
    }
    
    /// Ensure that HouseViewModel returns the correct HouseDetailtem for a given row with the correct data
    func test_should_return_correct_houseDetailItem_at_index() {
        sut.populateHouseDetails()
        let houseDetailItem1 = sut.houseDetailItemForIndex(0)
        let houseDetailItem2 = sut.houseDetailItemForIndex(4)
        let houseDetailItem3 = sut.houseDetailItemForIndex(6)
        XCTAssertEqual(houseDetailItem1.title, "Name")
        XCTAssertEqual(houseDetailItem1.value, "Test House")
        XCTAssertEqual(houseDetailItem2.title, "Titles")
        XCTAssertEqual(houseDetailItem2.value, "Lord Scott\nKing Kuda\n")
        XCTAssertEqual(houseDetailItem3.title, "Founded")
        XCTAssertEqual(houseDetailItem3.value, "1900 BC")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
