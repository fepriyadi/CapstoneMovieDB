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
let movieUseCase: Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>> = injection.provideMovie()
let favUseCase: FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>> = injection.provideFavorite()

let listFavUseCase: Interactor<String, [Movie], GetFavMoviesRepository<GetFavMoviesDataSource>> = injection.provideFavorites()
let searchUseCase: Interactor<String, [Movie], SearchMoviesRepository<GetMoviesDataSource>> = injection.provideSearch()

@main
struct CapstoneDicodingApp: SwiftUI.App {
    
    let moviesPresenter = MoviesPresenter(moviesUseCase: homeUseCase)
    let detailPresenter = MoviePresenter(movieUseCase: movieUseCase, favoriteUseCase: favUseCase)
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
