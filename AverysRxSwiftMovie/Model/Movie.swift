//
//  Movie.swift
//  AverysRxSwiftMovie
//
//  Created by AveryW on 2/23/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let releaseDate: String?
    public let adult: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "title"
        case overview = "overview"
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
        case adult = "adult"
    }
}
