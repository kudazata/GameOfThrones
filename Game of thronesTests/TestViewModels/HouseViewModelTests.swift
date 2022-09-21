//
//  HouseViewModelTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseViewModelTests: XCTestCase {
    
    var house: House!
    var houseViewModel: HouseViewModel!

    override func setUpWithError() throws {
    
        house = House(url: "", name: "Test House", region: "Test region", coatOfArms: "A golden wreath", words: "No words", titles: ["Lord", "King"], seats: ["Godsgrace", ""], currentLord: "Lord Bayley", heir: "Lord Jeffery", overlord: "House of commons", founded: "1900", founder: "Lord disick", diedOut: "1920", ancestralWeapons: ["Knife", "Gun"], cadetBranches: ["", ""], swornMembers: ["Ariana", "Caroline"])
        houseViewModel = HouseViewModel(house)

    }

    
    /// Ensure that HouseViewModel populates correct value for name from House object
    func test_should_return_correct_name() {
        XCTAssertEqual(houseViewModel.name, "Test House")
    }

    /// Ensure that HouseViewModel populates correct value for region from House object
    func test_should_return_correct_region() {
        XCTAssertEqual(houseViewModel.region, "Test region")
    }
    
    override func tearDownWithError() throws {
        house = nil
        houseViewModel = nil
    }
}
