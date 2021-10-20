//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Sharu on 18/03/21.
//  Copyright © 2021 Sharu. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTests: XCTestCase {

    func test_viewDidLoad_rendersHeaderText()
    {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    
    func test_viewDidLoad_withOptions_rendersOptions()
    {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection : 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection : 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.numberOfRows(inSection : 0), 2)
    }
    
    func test_viewDidLoad_withOptions_rendersOptionsText()
    {
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.title(at: 1), "A2")

    }
    
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWhenOptionChanges()
    {
        var receivedAnswer = [String]()
        
        let sut = makeSUT(options: ["A1","A2"]){
            receivedAnswer = $0
        }
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection()
    {
        var callbackCount = 0
        
        let sut = makeSUT(options: ["A1","A2"]){ _ in callbackCount += 1
        }
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)

    }
    
    func test_optionSelected_withMultipleOptionsEnabled_notifiesDelegateWhenOptionChanges()
    {
        var receivedAnswer = [String]()
        
        let sut = makeSUT(options: ["A1","A2"]){
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1","A2"])
    }
    
    func test_optionDeselected_withMultipleOptionsEnabled_notifiesDelegate()
    {
        var receivedAnswer = [String]()
        
        let sut = makeSUT(options: ["A1","A2"]){
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    
    
    
    //MARK :- Helpers
    
     func makeSUT(question:String = "Q1",
                        options:[String] = [],
                        selection:@escaping([String]) -> Void = { _ in }) -> QuestionViewController
           {
               let sut = QuestionViewController(question: question,options:options,selection:selection)
               _ = sut.view
               return sut
           }
    
}

