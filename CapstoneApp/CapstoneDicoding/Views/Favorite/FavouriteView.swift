//
//  FavouriteView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Core
import Movie

struct FavouriteView: View {
    @ObservedObject var presenter: GetListPresenter<String, Movie, Interactor<String, [Movie], GetFavMoviesRepository<GetFavMoviesDataSource>>>
    @ObservedObject var detailPresenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>> >
    var body: some View {
            NavigationView {
                    ZStack(alignment: .topLeading) {
                        Group {
                            if !self.presenter.isLoading{
                                if self.presenter.list.count > 0{
                                    BackdropFavView(movies: self.presenter.list, presenter: detailPresenter)
                                }else{
                                    Text("msg_empty_fav".localized(identifier: "id.dicoding.CapstoneDicoding"))
                                }
                            } else {
                                LoadingView(isLoading: self.presenter.isLoading, error: nil) {
                                    self.presenter.getList(request: nil)
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .navigationBarTitle("title_favorite".localized(identifier: "id.dicoding.CapstoneDicoding"))
            }
            .onAppear {
                self.presenter.getList(request: nil)
            }
    }
}

//#Preview {
//    FavouriteView()
//}

