//
//  MovieDetailView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Core
import Movie

struct MovieDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject private var presenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>, FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>> >
    var movieId: Int
    private var isfavorite: Bool{
        get{ return presenter.movieObj?.favorite ?? false }
    }
    init(movieId: Int, presenter: MoviePresenter<Interactor<String, Movie, GetMovieRepository<GetMovieDataSource>>,
         FavInteractor<String, MovieObject, GetFavMovieRepository<GetFavMoviesDataSource>>>) {
        self.presenter = presenter
        self.movieId = movieId
    }
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.presenter.isLoading, error: nil) {
                self.presenter.getMovie(request: self.movieId.description)
            }
            
            if presenter.item != nil {
                MovieDetailListView(movie: self.presenter.item!)
            }
        }
        .toast(message: presenter.msg, isShowing: $presenter.isShowing,
               duration: Toast.long)
        .navigationBarTitle(presenter.item?.title ?? "")
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
        })
        .onAppear {
            UITabBar.appearance().isHidden = true
            self.presenter.getMovie(request: self.movieId.description)
            self.presenter.isFavorite(id: self.movieId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem{
                Menu {
                    Button(action: {
                        if let item = self.presenter.item?.toClass(){
                            if isfavorite{
                                self.presenter.removeFavorite(request: item)
                            }else{
                                self.presenter.addFavorite(request: item)
                            }
                        }
                    }, label: {
                        if isfavorite {
                            Label("btn_remove_fav".localized(identifier: "id.dicoding.CapstoneDicoding"), systemImage: "heart.fill")
                        }else{
                            Label("btn_add_fav".localized(identifier: "id.dicoding.CapstoneDicoding"), systemImage: "heart")
                        }
                    })

                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                }
            }
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    @State
    private var selectedTrailer: MovieVideo?
    @StateObject
    var imageLoader = ImageLoader()
    
    var body: some View {
        List {
            ZStack{
                MovieDetailImage(imageURL: self.movie.backdropURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .onAppear{
                        print("onappear MovieDetailImage()")
                    }
            }
            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if movie.cast.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movie.cast.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                }
                
                if movie.crew.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.movie.directors.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movie.producers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screenwriter(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
            
            if movie.youtubeTrailers.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(movie.youtubeTrailers) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }){
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
    }
}

struct MovieDetailImage: View {
    var imageURL: URL
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    // Placeholder or error handling view
                    Text("msg_failed_img".localized(identifier: "id.dicoding.CapstoneDicoding"))
                } else {
                    // Placeholder view while loading
                    Rectangle().fill(Color.gray.opacity(0.3))
                }
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MovieDetailView(movieId: Movie)
//        }
//    }
//}
