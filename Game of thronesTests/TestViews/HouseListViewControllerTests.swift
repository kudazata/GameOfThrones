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

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "HouseList", bundle: nil).instantiateViewController(withIdentifier: "houseListVC") as? HouseListViewController
        sut.webService = WebServiceMock(shouldReturnError: false)
        _ = sut.view
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    ///Ensure that tableView in HouseListViewController returns 2 sections
    func testTableView_shouldReturnCorrectNumberOfSections() {
        XCTAssertEqual(sut.tableView.numberOfSections, 2)
    }
    
    ///Ensure that tableView in HouseListViewController returns correct number of rows from the data source
    func testTableView_shouldReturnCorrectNumberOfRows() {
        sut.tableView.reloadData()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

}
