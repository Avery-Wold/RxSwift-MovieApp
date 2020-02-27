//
//  MovieRequest.swift
//  AverysRxSwiftMovie
//
//  Created by AveryW on 2/23/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import Foundation

class MovieRequest: APIRequest {
    var method = HttpMethod.get
    var path = "search/movie/"
    var parameters = [String: String]()
    
    init(title: String) {
        parameters["api_key"] = "3641d5be7403c8cc947c6ca585df281d"
        parameters["query"] = title
    }
}
