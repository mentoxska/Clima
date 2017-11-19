//
//  ClimaUITests.swift
//  ClimaUITests
//
//  Created by Branislav on 19/11/2017.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import XCTest

class ClimaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetEmptyCity() { //nezadane mesto - vypis weather unavailable - PASSED

        let app = XCUIApplication()
          app.buttons["switch"].tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        app.buttons["Get Weather"].tap()

        XCTAssertTrue(app.staticTexts["Weather unavailable"].exists)


    }

    func testWeatherWeirdSymbols(){ //zadanie divnych znakov - PASSED

        let app = XCUIApplication()
        app.buttons["switch"].tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("!@#$%^&*()_?\":}")
        app.buttons["Get Weather"].tap()

         XCTAssertTrue(app.staticTexts["Weather unavailable"].exists)

    }

    func testGetWeatherWithCity1(){ //obycajny test pre mesto Presov - PASSED


        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Presov")
        app.buttons["Get Weather"].tap()

        XCTAssertTrue(app.staticTexts["Presov"].exists)


    }
    func testGetWeatherWithCity2(){//obycajny test pre mesto Kosice - PASSED

        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        app.buttons["Get Weather"].tap()

        XCTAssertTrue(app.staticTexts["Kosice"].exists)

    }
    func testGetWeatherWithCity3(){ // Testovane mesto s medzerami 1 - PASSED

        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Tel aviv\r")
        app.buttons["Get Weather"].tap()

         XCTAssertTrue(app.staticTexts["Tel Aviv"].exists)
    }
    func testGetWeatherWithCity4(){// Testovane male mesto s dlhym nazvom a divnymi znakmi -- FAILED


        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Jászfelsőszentgyörgy")
        app.buttons["Get Weather"].tap()

        XCTAssertTrue(app.staticTexts["Jászfelsőszentgyörgy"].exists)
    }
    func testDefaultGPS(){ // test na aktualnu polohu po spusteni - Honolulu v simulatore - PASSED
         XCTAssertTrue(app.staticTexts["Honolulu"].exists)
    }

    
    func testUnexistentCity(){ // test na neexistujuce mesto - PASSED



        let app = XCUIApplication()
        app.buttons["switch"].tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("asdasdasdasdadsdasda")
        app.buttons["Get Weather"].tap()

        XCTAssertTrue(app.staticTexts["Weather unavailable"].exists)


    }

    func testMultipleSeguesAndGetCityWeather(){ // zmen viackrat obrazovku a potom ziskaj mesto - PASSED

        let app = XCUIApplication()
        let switchButton = app.buttons["switch"]
        switchButton.tap()

        let leftButton = app.buttons["left"]
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Bratislava")
        app.buttons["Get Weather"].tap()
        switchButton.tap()
        leftButton.tap()
        switchButton.tap()
        leftButton.tap()

        XCTAssertTrue(app.staticTexts["Bratislava"].exists)
    }
    
    func testWriteInTextfieldAndGoBackAndGetCity(){ //zadaj nieco potom zmen screen, vrat sa a zmen mesto na Kosice - PASSED


        let app = XCUIApplication()
        let button = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element
        button.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("sdlkjaldskj")
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        app.buttons["Get Weather"].tap()


        XCTAssertTrue(app.staticTexts["Kosice"].exists)
    }

    func testTypeSomethingGoBackAndContinueTyping(){ //test na to, ze ak nieco zadame do textfieldu a ideme na iny screen a vratime sa ci to tam ostane -  FAILED

        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let button = element.children(matching: .button).element
        button.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Pre")
        app.buttons["left"].tap()
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("sov")
        element.tap()

        let getWeatherButton = app.buttons["Get Weather"]
        getWeatherButton.tap()

        XCTAssertTrue(app.staticTexts["Presov"].exists)
    }

    func testTapSomewhere(){ //test na spadnutie - klikaj hocikde - PASSED

        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        element.tap()
        element.tap()

        let staticText = app.staticTexts["24°"]
        staticText.tap()
        staticText.tap()

        let element2 = element.children(matching: .other).element
        element2.tap()

        let honoluluStaticText = app.staticTexts["Honolulu"]
        honoluluStaticText.tap()
        element2.tap()
        element2.tap()
        honoluluStaticText.tap()
        element2.tap()
        element.tap()
        element.tap()
        element.children(matching: .button).element.tap()
        element.tap()
        element.tap()
        element.tap()
        app.textFields["Enter City Name"].tap()
        element.tap()
        element.tap()

    }

    func testTapSomewhereThenGetCity(){ // klikanie hocikde potom ziskaj mesto - PASSED


        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        app.staticTexts["24°"].tap()
        element.children(matching: .other).element.tap()
        app.staticTexts["Honolulu"].tap()
        element.tap()
        element.children(matching: .button).element.tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        app.buttons["Get Weather"].tap()

         XCTAssertTrue(app.staticTexts["Kosice"].exists)
    }
    
    func testSimpleMultitasking(){ // multitasking test - PASSED


        let app = XCUIApplication()
        app.buttons["switch"].tap()

        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Poprad")
        app.buttons["Get Weather"].tap()
        app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Home screen icons\"]",".otherElements[\"SBFolderScalingView\"].scrollViews",".scrollViews"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.otherElements.icons["Clima"].tap()


         XCTAssertTrue(app.staticTexts["Poprad"].exists)

    }
    
    func testChangeCityMultipleTimes(){ // menenie mesta viac krat - PASSED
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        
        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Poprad")
        
        let getWeatherButton = app.buttons["Get Weather"]
        getWeatherButton.tap()
        
        let button = element.children(matching: .button).element
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        getWeatherButton.tap()
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Presov")
        getWeatherButton.tap()
        
         XCTAssertTrue(app.staticTexts["Presov"].exists)
    }
    
    func testGetSameCityAsPrevious(){ // Otestuj zmena na rovnake mesto ako posledne zadane - PASSED
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        
        let enterCityNameTextField = app.textFields["Enter City Name"]
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Bratislava")
        
        let getWeatherButton = app.buttons["Get Weather"]
        getWeatherButton.tap()
        
        let button = element.children(matching: .button).element
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        getWeatherButton.tap()
        button.tap()
        enterCityNameTextField.tap()
        enterCityNameTextField.typeText("Kosice")
        getWeatherButton.tap()
        
        XCTAssertTrue(app.staticTexts["Kosice"].exists)
    }
    
}
