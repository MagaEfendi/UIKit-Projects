//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Mahammad Afandiyev on 13.02.23.
//

import Foundation
import XCTest

@testable import Bankey


class Test : XCTestCase {
    var formatter : CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
      
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testdollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466)
        XCTAssertEqual(result, "$929,466.00")
    }
}
