//
//  File.swift
//
//
//  Created by Fep on 22/07/24.
//

import Combine
import Core

public struct GetFavoriteMovieRepository<MoviesLocaleDataSource: LocaleDataSource>: Repository
where
MoviesLocaleDataSource.Request == String,
MoviesLocaleDataSource.Response == MovieObject{
    
    
    public typealias Request = String
    public typealias Response = MovieObject
    
    private let _localeDataSource: MoviesLocaleDataSource
    
    public init(localeDataSource: MoviesLocaleDataSource) {
        _localeDataSource = localeDataSource
    }
    
    public func execute(request: String?) -> AnyPublisher<MovieObject, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<MovieObject, any Error> {
        _localeDataSource.get(id: id)
            .eraseToAnyPublisher()
    }
    
    public func update(entity: MovieObject) -> AnyPublisher<MovieObject, any Error> {
        fatalError()
    }
    
    public func add(entity: MovieObject) -> AnyPublisher<MovieObject, any Error> {
        return _localeDataSource.add(entity: entity)
            .eraseToAnyPublisher()
    }
    
    public func remove(entity: MovieObject) -> AnyPublisher<MovieObject, any Error> {
        return _localeDataSource.update(entity: entity)
            .eraseToAnyPublisher()
    }
}
