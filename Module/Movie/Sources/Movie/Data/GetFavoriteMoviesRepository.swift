//
//  File.swift
//  
//
//  Created by Fep on 16/07/24.
//

import Combine
import Core

public struct GetFavoriteMoviesRepository<MoviesLocaleDataSource: LocaleDataSource>: Repository
where
    MoviesLocaleDataSource.Request == String,
MoviesLocaleDataSource.Response == MovieObject{

    public typealias Request = String
    public typealias Response = [Movie]
    
    private let _localeDataSource: MoviesLocaleDataSource
    
    public init(localeDataSource: MoviesLocaleDataSource) {
        _localeDataSource = localeDataSource
    }
    
    public func execute(request: String?) -> AnyPublisher<[Movie], Error> {
        return _localeDataSource.list(request: request)
            .map{ result in
                result.map{ moviObj in
                    moviObj.toStruct()
                }
            }
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
