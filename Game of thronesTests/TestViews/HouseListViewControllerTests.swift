//
//  HouseListViewControllerTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 20/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseListViewControllerTests: XCTestCase {
    
    var sut: HouseListViewController!
    var houseListViewModel: HouseListViewModel!
    var house1: House!
    var house2: House!

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "HouseList", bundle: nil).instantiateViewController(withIdentifier: "houseListVC") as? HouseListViewController
        houseListViewModel = HouseListViewModel()
        
        house1 = House(url: "",
                       name: "Test House 1",
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
        
        house2 = House(url: "",
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
        
        sut.houseListViewModel = houseListViewModel
    }

    override func tearDownWithError() throws {
    }
    
    ///Ensure that tableView in HouseListViewController returns 2 sections
    func testTableView_shouldReturnCorrectNumberOfSections() {
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
    }
    
    ///Ensure that tableView in HouseListViewController returns correct number of rows from the data source
    func testTableView_shouldReturnCorrectNumberOfRows() {
        houseListViewModel.houses = [house1, house2, house1, house2]
        sut.tableView.reloadData()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
    }

}
