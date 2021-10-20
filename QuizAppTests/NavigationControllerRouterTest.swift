//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Sharu on 27/07/21.
//  Copyright © 2021 Sharu. All rights reserved.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest : XCTestCase
{
    let navigationController = NonAnimatedViewController()
    
    let factory = ViewControllerFactoryStub()
    lazy var sut:NavigationControllerRouter =
    {
        return NavigationControllerRouter(self.navigationController,factory: self.factory)
    }()
    
    
    func test_routesToSecondQuestion_presentsQuestionController()
       {
           //Given
           
           let viewController = UIViewController()
           let secondViewController = UIViewController()
        
           factory.stub(question:"Q1",with:viewController)
           factory.stub(question:"Q2",with:secondViewController)
           
        
           //When
           sut.routeTo(question:"Q1",answerCallback:{_ in })
           sut.routeTo(question:"Q2",answerCallback:{_ in })
           
           //Then
           XCTAssertEqual(navigationController.viewControllers.first, viewController)
           XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
       }
    
    func test_routesToQuestion_presentsQuestionControllerWithRightcallback()
    {

        //When
        var callbackWasfired = false
        sut.routeTo(question:"Q1",answerCallback:{_ in callbackWasfired = true})
        
        factory.answerCallback["Q1"]!("ANYTHING")
        
        //Then
        XCTAssertTrue(callbackWasfired)
       
    }
    
    class NonAnimatedViewController : UINavigationController{
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub:ViewControllerFactory
    {
        
        var stubbedQuestions = [String:UIViewController]()
        var answerCallback = [String:(String) -> Void]()
        
        func stub(question:String,with viewController:UIViewController)
        {
            stubbedQuestions[question] = viewController
        }
        
        func QuestionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
        self.answerCallback[question] = answerCallback
                  return stubbedQuestions[question] ?? UIViewController()
                 
              }
        
    }
    
}
