//
//  File.swift
//  
//
//  Created by Fep on 23/07/24.
//

import Core
import Combine

public protocol FavoriteUseCase: UseCase {
    func execute(request: Request?) -> AnyPublisher<Response, Error>
    func get(id: Int) -> AnyPublisher<Response, Error>
    func addFavorite(entity: Response) -> AnyPublisher<Response, Error>
    func removeFavorite(entity: Response) -> AnyPublisher<Response, Error>
}
