//
//  MoviePosterCourselView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Core
import Movie

struct MoviePosterCarouselView: View {
    let title: String
    let movies: [Movie]
    @ObservedObject
    var presenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>>>
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, presenter: self.presenter)) {
                            MoviePosterCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}
