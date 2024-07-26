//
//  SearchView.swift
//  CapstoneDicoding
//
//  Created by Fep on 23/07/24.
//

import SwiftUI
import Core
import Movie

struct SearchView: View {
    
    @ObservedObject var presenter: SearchPresenter<Movie, Interactor<String, [Movie], SearchMoviesRepository<GetMoviesDataSource>>>
    
    @ObservedObject var detail: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>>>
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(
                    text: $presenter.keyword,
                    onSearchButtonClicked: presenter.search
                )
                
                ZStack(alignment: .topLeading) {
                    if presenter.isLoading {
                        loadingIndicator
                    } else if presenter.keyword.isEmpty {
                        emptyTitle
                    } else if presenter.list.isEmpty {
                        emptyMeals
                    } else if presenter.isError {
                        errorIndicator
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(alignment: .center, spacing: 16) {
                                ForEach(self.presenter.list) { movie in
                                    NavigationLink(destination: MovieDetailView(movieId: movie.id, presenter: self.detail)) {
                                        SearchRow(movie: movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.leading, 16)
                                    .padding(.trailing, 16)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }.navigationBarTitle(
                Text("title_search".localized(identifier: "id.dicoding.CapstoneDicoding")),
                displayMode: .automatic
            )
        }
    }
}

extension SearchView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicatorView()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetErrorNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyTitle: some View {
        CustomEmptyView(
            image: "assetSearchMovie",
            title: "msg_find_fav".localized(identifier: "id.dicoding.CapstoneDicoding")
        ).offset(y: 50)
    }
    var emptyMeals: some View {
        CustomEmptyView(
            image: "assetNotFound",
            title: "msg_not_found".localized(identifier: "id.dicoding.CapstoneDicoding")
        ).offset(y: 80)
    }
    
}
