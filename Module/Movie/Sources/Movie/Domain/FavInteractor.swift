//
//  File.swift
//  
//
//  Created by Fep on 23/07/24.
//

import Foundation
import Combine
import Core

public struct FavInteractor<Request, Response, R: Repository>: FavoriteUseCase
where R.Request == Request, R.Response == Response{
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, any Error> {
        _repository.execute(request: request)
    }
    
    public func get(id: Int) -> AnyPublisher<Response, any Error> {
        _repository.get(id: id)
    }
    
    public func addFavorite(entity: Response) -> AnyPublisher<Response, any Error> {
        _repository.add(entity: entity)
    }
    
    public func removeFavorite(entity: Response) -> AnyPublisher<Response, any Error> {
        _repository.remove(entity: entity)
    }
}
