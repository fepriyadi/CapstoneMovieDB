//
//  File.swift
//  
//
//  Created by Fep on 16/07/24.
//

import Core
import Combine

public struct GetMovieRepository<RemoteDataSource: DataSource>: Repository where
RemoteDataSource.Request == String,
RemoteDataSource.Response == Movie
{
    public typealias Request = String
    public typealias Response = Movie
    
    private let _remoteDataSource: RemoteDataSource
    
    public init(remoteDataSource: RemoteDataSource) {
        self._remoteDataSource = remoteDataSource
    }
    
    public func execute(request: String?) -> AnyPublisher<Movie, Error> {
        return _remoteDataSource.execute(request: request)
          .eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<Movie, any Error> {
        fatalError()
    }
    
    public func update(entity: Movie) -> AnyPublisher<Movie, any Error> {
        fatalError()
    }
    
    public func add(entity: Movie) -> AnyPublisher<Movie, any Error> {
        fatalError()
    }
    
    public func remove(entity: Movie) -> AnyPublisher<Movie, any Error> {
        fatalError()
    }
    
}
