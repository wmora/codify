//
//  IssuesServiceTest.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import XCTest
import Codify

class IssuesServiceTest: XCTestCase {

    func testExample() {
        let issuesService = IssuesService(owner: "nispok", repo: "codify")
        
        let url = issuesService.fullURL()
        
        XCTAssertEqual("https://api.github.com/repos/nispok/codify/issues", url.description)
    }

}
