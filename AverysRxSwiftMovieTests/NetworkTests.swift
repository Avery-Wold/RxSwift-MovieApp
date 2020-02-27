//
//  NetworkTests.swift
//  AverysRxSwiftMovieTests
//
//  Created by AveryW on 2/26/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import XCTest
@testable import AverysRxSwiftMovie

class NetworkTests: XCTestCase {
    
    func testSUT_NetworkCallCodable() {
        guard let movieURL = URL(string: "https://api.themoviedb.org/3/search/movie/?api_key=3641d5be7403c8cc947c6ca585df281d&query=Lord of the Rings: The Fellowship of the Ring") else { return }
        let promise = expectation(description: "Codable Request")
        URLSession.shared.dataTask(with: movieURL) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let movieData = try decoder.decode(Movie.self, from: data)
                XCTAssertTrue(movieData.title == "The Lord of the Rings: The Fellowship of the Ring")
                XCTAssertTrue(movieData.overview == "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.")
                XCTAssertTrue(movieData.releaseDate == "2001-12-18")
                XCTAssertTrue(movieData.posterPath == "/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg")
                promise.fulfill()
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testSUT_NetworkCall() {
        guard let movieURL = URL(string: "https://api.themoviedb.org/3/search/movie/?api_key=3641d5be7403c8cc947c6ca585df281d&query=evil+dead") else { return }
        let promise = expectation(description: "Simple Request")
        URLSession.shared.dataTask(with: movieURL) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    let results = result["results"]
                    print(results!)
                    XCTAssertNotNil(result["results"])
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSUT_GetNetworkData() {
        guard let movieURL = URL(string: "https://api.themoviedb.org/3/search/movie/?api_key=3641d5be7403c8cc947c6ca585df281d&query=Lord of the Rings: The Fellowship of the Ring") else { return }
        let promise = expectation(description: "Simple Request")
        URLSession.shared.dataTask(with: movieURL) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["title"] as! String == "The Lord of the Rings: The Fellowship of the Ring")
                    XCTAssertTrue(result["overview"] as! String == "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.")
                    XCTAssertTrue(result["realease_date"] as! String == "2001-12-18")
                    XCTAssertTrue(result["poster_path"] as! String == "/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg")
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
