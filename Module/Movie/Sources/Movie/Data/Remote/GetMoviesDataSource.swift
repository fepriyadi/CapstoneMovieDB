//
//  File.swift
//
//
//  Created by Fep on 16/07/24.
//

import Core
import Combine
import Foundation
import Alamofire
import Movie

public struct GetMoviesDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = [Movie]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<[Movie], Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            let url = _endpoint + request
            
            AlamofireLogger.shared.request(url)
                .validate()
                .responseDecodable(of: MovieResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        let movies = value.results.map{
                            Movie(from: $0, source: MovieListEndpoint(rawValue: request))
                        }
                        completion(.success(movies))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
}

