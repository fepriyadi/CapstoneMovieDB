//
//  SearchRow.swift
//  CapstoneDicoding
//
//  Created by Fep on 23/07/24.
//

import SwiftUI
import Movie

struct SearchRow: View {

@ObservedObject var imageLoader = ImageLoader()
  var movie: Movie

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        movieImage
        content
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)

      Divider()
        .padding(.leading, 8)
        
    }
  }

}

extension SearchRow {

    var movieImage: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 104, height: 206)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(movie.title)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .lineLimit(3)

        Text(movie.overview)
        .font(.system(size: 16))
        .lineLimit(8)

//      if !movie..isEmpty {
//        Text("From \(meal.area)")
//          .font(.system(size: 14))
//          .lineLimit(2)
//      }

    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}
