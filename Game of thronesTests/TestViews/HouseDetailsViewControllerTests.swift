//
//  HouseDetailsViewControllerTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseDetailsViewControllerTests: XCTestCase {
    
    var sut: HouseDetailsViewController!
    var house: House!
    var houseDetailsViewModel: HouseDetailsViewModel!

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
                      diedOut: "",
                      ancestralWeapons: ["Sharp Knife", "big shotgun"],
                      cadetBranches: ["https://anapioficeandfire.com/api/houses/6", "https://anapioficeandfire.com/api/houses/8"],
                      swornMembers: ["https://anapioficeandfire.com/api/characters/298", "https://anapioficeandfire.com/api/characters/1301"])
        
        sut = UIStoryboard(name: "HouseDetails", bundle: nil).instantiateViewController(withIdentifier: "houseDetailsVC") as? HouseDetailsViewController
        sut.house = house
        sut.webService = WebServiceMock(shouldReturnError: false)
        _ = sut.view
        
    }
    
    ///Ensure that tableView in HouseDetailsViewController returns correct number of rows
    func testTableView_ShouldReturnCorrectNumberOfRows() {
        houseDetailsViewModel = HouseDetailsViewModel()
        houseDetailsViewModel.house = house
        houseDetailsViewModel.populateHouseDetails()
        sut.houseDetailsVM = houseDetailsViewModel
        
        sut.tableView.reloadData()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 8)
    }
    
    ///Ensure that tableView in HouseDetailsViewController returns 1 section
    func testTableView_NumberOfSections_ShouldReturnOne() {
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }

    override func tearDownWithError() throws {
        sut = nil
        house = nil
    }


}
