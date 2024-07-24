//
//  CapstoneDicodingApp.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import RealmSwift
import Core
import Movie

let injection = Injection()

let homeUseCase: Interactor<String, [Movie], GetMoviesRepository<GetMoviesDataSource>> = injection.provideMovies()
let _movieUseCase: Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>> = injection.provideMovie()
let favUseCase: FavoriteInteractor<String, MovieObject, GetFavoriteMovieRepository<GetFavoriteMoviesDataSource>> = injection.provideFavorite()

let listFavUseCase: Interactor<String, [Movie], GetFavoriteMoviesRepository<GetFavoriteMoviesDataSource>> = injection.provideFavorites()
let searchUseCase: Interactor<String, [Movie], SearchMoviesRepository<GetMoviesDataSource>> = injection.provideSearch()

@main
struct CapstoneDicodingApp: SwiftUI.App {
    
    let moviesPresenter = MoviesPresenter(moviesUseCase: homeUseCase)
    let detailPresenter = MoviePresenter(movieUseCase: _movieUseCase, favoriteUseCase: favUseCase)
    let favoritePresenter = GetListPresenter(useCase: listFavUseCase)
    let searchPresenter = SearchPresenter(useCase: searchUseCase)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(moviesPresenter)
                .environmentObject(detailPresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(searchPresenter)
        }
    }
}
