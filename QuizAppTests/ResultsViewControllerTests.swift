//
//  ResultsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Sharu on 05/05/21.
//  Copyright © 2021 Sharu. All rights reserved.
//

import XCTest
@testable import QuizApp

class ResultsViewControllerTests: XCTestCase {

    func test_viewDidLoad_rendersSummary()
    {
        let sut = ResultsViewController(summary:"a summary",answers:[])
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "A Summary")
    }
    
    func test_viewDidLoad_withoutAnswers_doesNotRenderAnswer()
    {
        let sut = ResultsViewController(summary:"a summary",answers:[])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 0)
    }
    
    func test_viewDidLoad_withOneAnswer_rendersAnswer()
    {
       let sut = ResultsViewController(summary:"a summary",answers:["A1"])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection:0), 1)
    }

}
