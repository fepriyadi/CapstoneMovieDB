//
//  ContentView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Core
import Movie

struct ContentView: View {
    let tabs = ["Movies", "Search", "Favorite", "About"]
    @EnvironmentObject var moviesPresenter : MoviesPresenter<Interactor<String, [Movie], GetMoviesRepository<GetMoviesDataSource>>>
    @EnvironmentObject var detailPresenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>> >
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, Movie, Interactor<String, [Movie], GetFavMoviesRepository<GetFavMoviesDataSource>>>
    @EnvironmentObject var searchPresenter: SearchPresenter<Movie, Interactor<String, [Movie], SearchMoviesRepository<GetMoviesDataSource>>>
    var body: some View {
        TabView {
            MovieListView(homePresenter: moviesPresenter, detailPresenter: detailPresenter)
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text(tabs[0])
                    }
            }
            .tag(0)
            SearchView(presenter: searchPresenter, detail: detailPresenter)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text(tabs[1])
                    }
                }
            .tag(1)
            FavouriteView(presenter: favoritePresenter, detailPresenter: detailPresenter)
                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text(tabs[2])
                    }
                }
            .tag(2)
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text(tabs[3])
                    }
                }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
