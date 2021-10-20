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
        XCTAssertEqual(makeSUT(summary: "a summary").headerLabel.text, "A Summary")
    }
    
    func test_viewDidLoad_rendersAnswers()
    {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection:0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection:0), 1)
    }
    
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell()
    {
        let answer = makeAnswer(question: "Q1",answer: "A1")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }

    
    func test_viewDidLoad_withWrongAnswer_configuresCell()
    {
        let answer = makeAnswer(question: "Q1",answer: "A1",wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    //MARK :- Helpers
    
    func makeSUT(summary:String = "a summary",answers:[PresentableAnswer] = []) -> ResultsViewController
    {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    
    func makeAnswer(question:String = "",answer:String = "",wrongAnswer:String? = nil) -> PresentableAnswer
    {
        return PresentableAnswer(question: question,answer: answer, wrongAnswer: wrongAnswer)
    }

}
