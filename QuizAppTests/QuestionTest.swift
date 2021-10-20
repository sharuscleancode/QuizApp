//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Sharu on 25/08/21.
//  Copyright © 2021 Sharu. All rights reserved.
//

import UIKit
import XCTest
@testable import QuizApp

class QuestionTest : XCTestCase
{
    func test_hashValue_singleAnswer_returnsTypeHash()
    {
        let type = "a string"
        
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(type.hashValue, sut.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash()
    {
        let type = "a string"
        
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(type.hashValue, sut.hashValue)
    }
    
    func test_equal_isEqual()
    {
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
        XCTAssertEqual(Question.multipleAnswer("a multiple string"), Question.multipleAnswer("a multiple string"))
    }
    
    func test_notEqual_isNotEqual()
    {
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
        XCTAssertNotEqual(Question.multipleAnswer("a multiple string"), Question.multipleAnswer("another multiple string"))
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.multipleAnswer("another multiple string"))
        XCTAssertNotEqual(Question.singleAnswer("a multiple string"), Question.multipleAnswer("a multiple string"))
    }
    
}
