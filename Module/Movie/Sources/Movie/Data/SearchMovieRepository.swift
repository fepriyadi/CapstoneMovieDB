//
//  File.swift
//  
//
//  Created by Fep on 16/07/24.
//

import Core
import Combine
import Movie

public struct SearchMoviesRepository<RemoteDataSource: DataSource>: Repository where
RemoteDataSource.Request == String,
RemoteDataSource.Response == [Movie]
{
    
    public typealias Request = String
    public typealias Response = [Movie]
    
    private let remoteDataSource: RemoteDataSource
    
    public init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func execute(request: String?) -> AnyPublisher<[Movie], Error> {
        var parameters :[String: Any] = [:]
        if let query = request{
            parameters = [
                "language": "en-US",
                "include_adult": "false",
                "region": "US",
                "query": query
            ]
        }
        
        let params = Utils.extractParams(parameters: parameters)
        
        return remoteDataSource.execute(request: params)
            .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<[Movie], any Error> {
        fatalError()
    }
    
    public func update(entity: [Movie]) -> AnyPublisher<[Movie], any Error> {
        fatalError()
    }
    
    public func add(entity: [Movie]) -> AnyPublisher<[Movie], any Error> {
        fatalError()
    }
    
    public func remove(entity: [Movie]) -> AnyPublisher<[Movie], any Error> {
        fatalError()
    }
}

