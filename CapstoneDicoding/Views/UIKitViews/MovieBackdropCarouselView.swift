//
//  MoviewBackdropCarouseView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Movie
import Core

struct MovieBackdropCarouselView: View {
    
    let title: String
    let movies: [Movie]
    @ObservedObject var presenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>,FavoriteInteractor<String, MovieObject, GetFavoriteMovieRepository<GetFavoriteMoviesDataSource>> >
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, presenter: self.presenter)) {
                            MovieBackdropCard(movie: movie, isFav: movie.isfavorite ?? false)
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

//struct MovieBackdropCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieBackdropCarouselView(title: "Latest", movies: Movie.stubbedMovies)
//    }
//}
