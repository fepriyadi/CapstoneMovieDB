//
//  MovieBackdropCard.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI
import Movie

struct MovieBackdropCard: View {
    
    let movie: Movie
    var isFav = false
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
        }
        .frame(width: isFav ? .infinity : 272, height: isFav ? .infinity : 200)
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

//struct MovieBackdropCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieBackdropCard(movie: Movie.stubbedMovie)
//    }
//}
