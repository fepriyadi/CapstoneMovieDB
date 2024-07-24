//
//  File.swift
//  
//
//  Created by Fep on 16/07/24.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetMovieDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = Movie
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<Movie, Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest) )}
            let params = [
                "append_to_response": "videos,credits"
            ]
            let url = _endpoint + request
            AlamofireLogger.shared.request(url, parameters: params)
                .validate()
                .responseDecodable(of: Movie.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
                                       
}
