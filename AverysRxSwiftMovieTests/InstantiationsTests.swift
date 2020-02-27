//
//  InstantiationsTests.swift
//  AverysRxSwiftMovieTests
//
//  Created by AveryW on 2/25/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import XCTest
@testable import AverysRxSwiftMovie

class InstantiationsTests: XCTestCase {
   
    func testSUT_MovieDetailsViewControllerInstantiation() {
        let _ = MovieDetailsViewController.init()
    }
    
    func testSUT_MoviesListViewControllerInstantiation() {
        let _ = SearchTableViewController.init()
    }
}
