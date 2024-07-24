//
//  BackdropFavView.swift
//  CapstoneDicoding
//
//  Created by Fep on 01/07/24.
//

import SwiftUI
import Core
import Movie

struct BackdropFavView: View {
    let movies: [Movie]
    @State private var isBack: Bool = false
    @ObservedObject var presenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavoriteInteractor<String, MovieObject, GetFavoriteMovieRepository<GetFavoriteMoviesDataSource>> >
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .center, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, presenter: presenter)) {
                            MovieBackdropCard(movie: movie, isFav: true)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
    }
}

//struct BackdropFavView_previews: PreviewProvider {
//    static var previews: some View {
//        BackdropFavView(movies: Movie.stubbedMovies)
//    }
//}
