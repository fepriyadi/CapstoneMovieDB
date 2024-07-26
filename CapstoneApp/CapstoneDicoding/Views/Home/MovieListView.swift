//
//  MovieListView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Core
import Movie

struct MovieListView: View {
    @ObservedObject var homePresenter: MoviesPresenter<Interactor<String, [Movie], GetMoviesRepository<GetMoviesDataSource>>>
    @ObservedObject var detailPresenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>> >
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationView {
            List {
                Group {
                    if homePresenter.list.count > 0  {
                        MoviePosterCarouselView(title: "Now Playing", movies: homePresenter.list.filter { $0.source == .nowPlaying }, presenter: detailPresenter)
                        
                    } else {
                        LoadingView(isLoading: homePresenter.isLoading, error: nil) {
                            homePresenter.getMovies(request: MovieListEndpoint.nowPlaying.rawValue)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    if homePresenter.list.count>0 {
                        MovieBackdropCarouselView(title: "Upcoming", movies: homePresenter.list.filter { $0.source == .upcoming }, presenter: detailPresenter)
                    } else {
                        LoadingView(isLoading: homePresenter.isLoading, error: nil) {
                            homePresenter.getMovies(request: MovieListEndpoint.upcoming.rawValue)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                Group {
                    if homePresenter.list.count>0 {
                        MovieBackdropCarouselView(title: "Top Rated", movies: homePresenter.list.filter { $0.source == .topRated }, presenter: detailPresenter)
                        
                    } else {
                        LoadingView(isLoading: self.homePresenter.isLoading, error: nil) {
                            homePresenter.getMovies(request: MovieListEndpoint.topRated.rawValue)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                Group {
                    if homePresenter.list.count>0 {
                        MovieBackdropCarouselView(title: "Popular", movies: homePresenter.list.filter { $0.source == .popular }, presenter: detailPresenter)
                    } else {
                        LoadingView(isLoading: homePresenter.isLoading, error: nil) {
                            homePresenter.getMovies(request: MovieListEndpoint.popular.rawValue)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("title_home".localized(identifier: "id.dicoding.CapstoneDicoding"))
        }
        .onAppear {
            homePresenter.getMovies(request: MovieListEndpoint.nowPlaying.rawValue)
            homePresenter.getMovies(request: MovieListEndpoint.upcoming.rawValue)
            homePresenter.getMovies(request: MovieListEndpoint.topRated.rawValue)
            homePresenter.getMovies(request: MovieListEndpoint.popular.rawValue)
        }
    }
}
