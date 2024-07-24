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
    @ObservedObject var presenter: GetListPresenter<String, Movie, Interactor<String, [Movie], GetFavoriteMoviesRepository<GetFavoriteMoviesDataSource>>>
    @ObservedObject var detailPresenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavoriteInteractor<String, MovieObject, GetFavoriteMovieRepository<GetFavoriteMoviesDataSource>> >
    
    var body: some View {
        VStack{
            NavigationView {
                    ZStack(alignment: .topLeading) {
                        Group {
                            if !self.presenter.isLoading{
                                if self.presenter.list.count > 0{
                                    BackdropFavView(movies: self.presenter.list, presenter: detailPresenter)
                                }else{
                                    Text("Hello, Add some your favorite movie :)")
                                }
                            } else {
                                LoadingView(isLoading: self.presenter.isLoading, error: nil) {
                                    self.presenter.getList(request: nil)
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .navigationBarTitle("Your Fav Movie")
            }
            .onAppear {
                self.presenter.getList(request: nil)
            }
        }
        
    }
}

//#Preview {
//    FavouriteView()
//}

