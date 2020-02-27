//
//  ApiRequest.swift
//  AverysRxSwiftMovie
//
//  Created by AveryW on 2/23/20.
//  Copyright © 2020 Avery. All rights reserved.
//

import Foundation
import RxSwift

public enum HttpMethod: String {
    case get, post, put, delete
}

protocol APIRequest {
    var method: HttpMethod { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension APIRequest {
    // Build the request for data from the API with parameters
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                             resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

final class APIClient {
    // Send the call to the API to get the data
    private let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: MoviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data ?? Data())
                    observer.onNext(model.results as! T)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

