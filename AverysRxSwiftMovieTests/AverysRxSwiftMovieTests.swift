//
//  AverysRxSwiftMovieTests.swift
//  AverysRxSwiftMovieTests
//
//  Created by AveryW on 2/23/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import XCTest
@testable import AverysRxSwiftMovie

class AverysRxSwiftMovieTests: XCTestCase {
    
    var SUTTableView: SearchTableViewController!
    var SUTMovieDetails: MovieDetailsViewController!

    override func setUp() {
        super.setUp()

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        SUTTableView = storyboard.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController
        
        SUTMovieDetails = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        
        // Set up for Detail View - Mock a Movie
        let movie = Movie(id: 333339, title: "Ready Player One", overview: "When the creator of a popular video game system dies, a virtual contest is created to compete for his fortune.", posterPath: "/pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg", releaseDate: "2018-03-28", adult: false)
        SUTMovieDetails.movie = movie
        
        // Load view hierarchy
        _ = SUTTableView.view
        _ = SUTMovieDetails.view

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_HasTableView() {
        XCTAssertNotNil(SUTTableView.tableView)
    }

    func testSUT_HasSearchhBar() {
        XCTAssertNotNil(SUTTableView.navigationItem.searchController?.searchBar)
    }
    
    func testSUT_ShouldSetSearchBarDelegate() {
        XCTAssertNotNil(SUTTableView.navigationItem.searchController?.searchBar.delegate)
    }
    
    func testSUT_TitleIsMovieSearch() {
        XCTAssertEqual("Movie Search", SUTTableView.title!)
    }
    
    func testSUT_HasTitleLabel() {
        XCTAssertNotNil(SUTMovieDetails.movieTitleLabel)
    }
    
    func testSUT_HasTitleLabelText() {
        XCTAssertNotNil(SUTMovieDetails.movieTitleLabel.text)
    }
    
    func testSUT_HasOverviewLabel() {
        XCTAssertNotNil(SUTMovieDetails.movieOverviewLabel)
    }
    
    func testSUT_HasOverviewLabelText() {
        XCTAssertNotNil(SUTMovieDetails.movieOverviewLabel.text)
    }
    
    func testSUT_HasReleaseDateLabel() {
        XCTAssertNotNil(SUTMovieDetails.movieReleaseDateLabel)
    }
    
    func testSUT_HasReleaseDateLabelText() {
        XCTAssertNotNil(SUTMovieDetails.movieReleaseDateLabel.text)
    }
    
    func testSUT_HasMoviePosterImageView() {
        XCTAssertNotNil(SUTMovieDetails.moviePosterImageView)
    }
}
