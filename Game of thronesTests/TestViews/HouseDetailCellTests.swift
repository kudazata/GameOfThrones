//
//  HouseDetailCellTests.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 21/9/2022.
//

import XCTest
@testable import Game_of_thrones

class HouseDetailCellTests: XCTestCase {
    
    var tableView: UITableView!

    override func setUpWithError() throws {
        
        let houseDetailsVC = UIStoryboard(name: "HouseDetails", bundle: nil).instantiateViewController(withIdentifier: "houseDetailsVC") as! HouseDetailsViewController
        tableView = houseDetailsVC.tableView
        
    }
    
    /// Ensure that HouseDetailCell is configured correctly with HouseDetailItemViewModel
    func testCell_ShouldConfigureWithHouseDetailItemViewModel() {
        let houseDetailItem = HouseDetailItem(title: "currentLord", value: "Lord Bayley")
        let houseDetailItemViewModel = HouseDetailItemViewModel(houseDetailItem)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! HouseDetailCell
        cell.configureCell(houseDetailItemVM: houseDetailItemViewModel)
        
        XCTAssertEqual(cell.detailTitle.text, "Current Lord")
        XCTAssertEqual(cell.detailInformation.text, "Lord Bayley")
    }

    override func tearDownWithError() throws {
        
    }


}
