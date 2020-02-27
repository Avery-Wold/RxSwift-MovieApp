//
//  MovieTests.swift
//  AverysRxSwiftMovieTests
//
//  Created by AveryW on 2/26/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import XCTest
@testable import AverysRxSwiftMovie

class MovieTests: XCTestCase {

    func testSUT_MovieHasData() {
        let movie = Movie(id: 333339, title: "Ready Player One", overview: "When the creator of a popular video game system dies, a virtual contest is created to compete for his fortune.", posterPath: "/pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg", releaseDate: "2018-03-28", adult: false)
        XCTAssertEqual(movie.title, "Ready Player One",
                       "Movie title should be set")
        XCTAssertEqual(movie.overview, "When the creator of a popular video game system dies, a virtual contest is created to compete for his fortune.",
                       "Movie overview should be set")
        XCTAssertEqual(movie.posterPath, "/pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg",
                       "Movie poster path should be set")
        XCTAssertEqual(movie.releaseDate, "2018-03-28",
                       "Movie release should be set")
    }
    
    func testSUT_NetworkCallInsertDataIntoModelCodable() {
        guard let movieURL = URL(string: "https://api.themoviedb.org/3/search/movie/?api_key=3641d5be7403c8cc947c6ca585df281d&query=Ready Player One") else { return }
        let promise = expectation(description: "Codable Request")
        URLSession.shared.dataTask(with: movieURL) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let movieData = try decoder.decode(Movie.self, from: data)
                let movie = Movie(id: movieData.id, title: movieData.title, overview: movieData.overview, posterPath: movieData.posterPath, releaseDate: movieData.releaseDate, adult: movieData.adult)
                XCTAssertEqual(movieData.title, movie.title)
                XCTAssertEqual(movieData.overview, movie.overview)
                XCTAssertEqual(movieData.releaseDate, movie.releaseDate)
                XCTAssertEqual(movieData.posterPath, movie.posterPath)
                promise.fulfill()
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 30, handler: nil)
    }
}
