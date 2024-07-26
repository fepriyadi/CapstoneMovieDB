//
//  Injection.swift
//  CapstoneDicoding
//
//  Created by Fep on 04/07/24.
//

import Foundation
import RealmSwift
import Core
import Movie

final class Injection: NSObject {
    private let realm = try? Realm()
    func provideMovies<U: UseCase>() -> U where U.Request == String, U.Response == [Movie] {
        let remote = GetMoviesDataSource(endpoint: Endpoints.Gets.movies.url)
        let repository = GetMoviesRepository(remoteDataSource: remote)
        return Interactor(repository: repository) as! U
    }
    func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [Movie] {
        let remote = GetMoviesDataSource(endpoint: Endpoints.Gets.search.url)
        let repository = SearchMoviesRepository(remoteDataSource: remote)
        return Interactor(repository: repository) as! U
    }
    func provideMovie<U: UseCase>() -> U where U.Request == String, U.Response == Movie {
        let remote = GetMovieDataSource(endpoint: Endpoints.Gets.movie.url)
        let repository = GetMovieRepository(remoteDataSource: remote)
        return Interactor(repository: repository) as! U
    }
    func provideFavorite<U: FavoriteUseCase>() -> U where U.Request == String, U.Response == MovieObject {
        let local = GetFavMoviesDataSource(realm: realm!)
        let repository = GetFavMovieRepository(localeDataSource: local)
        return FavInteractor(repository: repository) as! U
    }
    func provideFavorites<U: UseCase>() -> U where U.Request == String, U.Response == [Movie] {
        let local = GetFavMoviesDataSource(realm: realm!)
        let repository = GetFavMoviesRepository(localeDataSource: local)
        return Interactor(repository: repository) as! U
    }
}
