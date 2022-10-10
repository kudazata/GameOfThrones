//
//  HouseTableViewCellTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 21/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseTableViewCellTests: XCTestCase {
    
    var tableView: UITableView!

    override func setUpWithError() throws {
        
        let houseListVC = UIStoryboard(name: "HouseList", bundle: nil).instantiateViewController(withIdentifier: "houseListVC") as! HouseListViewController
        tableView = houseListVC.tableView
        
    }
    
    /// Ensure that HouseTableViewCell is configured correctly with HouseViewModel
    func testCell_ShouldConfigureWithHouseViewModel() {
        
        let house = House(url: "",
                          name: "Test House",
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
        
        let houseViewModel = HouseViewModel(house)
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell") as! HouseTableViewCell
        cell.configureCell(houseViewModel: houseViewModel)
        
        XCTAssertEqual(cell.nameLabel.text, "Test House")
        XCTAssertEqual(cell.regionLabel.text, "Test region")
    }

    override func tearDownWithError() throws {
        tableView = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
