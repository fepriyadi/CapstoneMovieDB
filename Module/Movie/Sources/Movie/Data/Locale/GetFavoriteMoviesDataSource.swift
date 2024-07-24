//
//  File.swift
//
//
//  Created by Fep on 16/07/24.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetFavoriteMoviesDataSource : LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = MovieObject
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[MovieObject], Error> {
        return Future<[MovieObject], Error> { completion in
            let movieEntities = {
                self._realm.objects(MovieObject.self)
                    .sorted(byKeyPath: "title", ascending: true)
                    .filter("favorite = \(true)")
            }()
            completion(.success(movieEntities.toArray(ofType: MovieObject.self) ?? [MovieObject].init()))
        }.eraseToAnyPublisher()
    }
    
    public func add(entity: MovieObject) -> AnyPublisher<MovieObject, any Error> {
        return Future<MovieObject, Error> { completion in
            do {
                try self._realm.write {
                    entity.setValue(true, forKey: "favorite")
                    self._realm.add(entity, update: .all)
                    completion(.success(entity))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func addlist(entities: [MovieObject]) -> AnyPublisher<[MovieObject], any Error> {
        return Future<[MovieObject], Error> { completion in
            do {
                try self._realm.write {
                    for movie in entities {
                        self._realm.add(movie, update: .all)
                    }
                    completion(.success(entities))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<MovieObject, Error> {
        return Future<MovieObject, Error> { completion in
            if let mealEntity = {
                self._realm.objects(MovieObject.self)
                    .filter("id = \(id)")
                    .filter("favorite = true")
            }().first{
                do {
                    completion(.success(mealEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(entity: MovieObject) -> AnyPublisher<MovieObject, Error> {
        return Future<MovieObject, Error> { completion in
            if let movieEnt = {
                self._realm.objects(MovieObject.self)
                    .filter("id = \(entity.id)")
            }().first{
                do {
                    try self._realm.write {
                        movieEnt.setValue(false, forKey: "favorite")
                    }
                    print("update movie \(movieEnt.favorite)")
                    completion(.success(movieEnt))
                }catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
}
