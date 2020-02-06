//
//  PredictionBuilderTests.swift
//  PredictionBuilder
//
//  Created by Denis Simon on 09/29/2017.
//  Copyright © 2017 PredictionBuilder. All rights reserved.
//

import XCTest
import PredictionBuilder

class PredictionBuilderTests: XCTestCase {
    
    var prediction: PredictionBuilder!
    
    override func setUp() {
        super.setUp()
        prediction = PredictionBuilder()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetResult() {
        let data: [[Double]] = [[1,20],[2,70],[2,45],[3,81],[5,73],[6,80],[7,110]]
        
        prediction.set(x: 4.5, data: data)
        var result = try! prediction.build()
        XCTAssertEqual(result.lnModel, "29.56362+10.46364x")
        XCTAssertEqual(result.y, 76.65)
        XCTAssertEqual(result.cor, 0.8348)
        
        prediction.set(x: 8)
        result = try! prediction.build()
        XCTAssertEqual(result.lnModel, "29.56362+10.46364x")
        XCTAssertEqual(result.y, 113.27274)
        XCTAssertEqual(result.cor, 0.8348)
    }
    
    func testException() {
        var data = [[Double]]()
        
        data = [[1,20],[2,70]]
        prediction.set(x: 4.5, data: data)
        XCTAssertThrowsError(try prediction.build()) { error in
            XCTAssertEqual(error as? ArgumentError, ArgumentError.general(msg: "The dataset should contain a minimum of 3 observations."))
        }
        
        data = [[1,20],[2,70],[2],[3,81],[5,73],[6,80],[7,110]]
        prediction.set(x: 4.5, data: data)
        XCTAssertThrowsError(try prediction.build()) { error in
            XCTAssertEqual(error as? ArgumentError, ArgumentError.general(msg: "Mismatch in the number of x and y in the dataset."))
        }
        
        data = [[1,20],[2,70],[],[3,81],[5,73],[6,80],[7,110]]
        prediction.set(x: 4.5, data: data)
        XCTAssertThrowsError(try prediction.build()) { error in
            XCTAssertEqual(error as? ArgumentError, ArgumentError.general(msg: "Mismatch in the number of x and y in the dataset."))
        }
    }
}
