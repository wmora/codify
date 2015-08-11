//
//  NSURL+QueryTest.swift
//  Codify
//
//  Created by William Mora on 10/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import XCTest
import Codify

class NSURL_QueryTest: XCTestCase {
    
    func testQueryParamsShouldReturnDictionaryOfQueryParams() {
        let url = NSURL(string: "http://example.com?param1=value1&param2=value2")
        let queryParams = url!.queryParams()
        
        XCTAssert(queryParams.count == 2)
        XCTAssertEqual(queryParams["param1"]!, "value1")
        XCTAssertEqual(queryParams["param2"]!, "value2")
    }
    
    func testQueryValueForKeyWithValidKeyShouldReturnValueAsString() {
        let url = NSURL(string: "http://example.com?a=123")
        
        XCTAssertEqual(url!.queryValueForKey("a"), "123")
    }
    
    func testQueryValueForKeyWithInvalidKeyShouldReturnEmptyString() {
        let url = NSURL(string: "http://example.com?param1=value1")
        
        XCTAssertEqual(url!.queryValueForKey("invalid_param"), "")
    }
    
}