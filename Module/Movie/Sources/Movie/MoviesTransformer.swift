//
//  File.swift
//  
//
//  Created by Fep on 15/07/24.
//

import Core

public struct MoviesTransformer: Mapper{
        
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: MovieResponse) -> [MovieObject] {
        return response.results.map { result in
            result.toClass()
        }
    }
    
    public func transformEntityToDomain(entity: [MovieObject]) -> [Movie] {
        return entity.map { result in
            return result.toStruct()
        }
    }
}
