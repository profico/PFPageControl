//
//  PFPageControlTests.swift
//  PFPageControlTests
//
//  Created by Ivan Ferencak on 19.03.2021..
//

import XCTest
@testable import PFPageControl

class PFPageControlTests: XCTestCase {

    var pageControl: PFPageControl!
    
    override func setUpWithError() throws {
        super.setUp()
        pageControl = PFPageControl()
    }

    override func tearDownWithError() throws {
        pageControl = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
