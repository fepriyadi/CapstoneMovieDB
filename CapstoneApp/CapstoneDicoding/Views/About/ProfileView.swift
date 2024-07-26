//
//  ProfileView.swift
//  CapstoneDicoding
//
//  Created by Fep on 22/05/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .center, spacing: 0){
                    Spacer()
                    Image("fep")
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .frame(width:200,height:200,alignment:.center)
                    Spacer()
                }
                
                HStack{
                    Text("Nama")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                    Text(":")
                    Text("Fepriyadi Harahap")
                }
                HStack{
                    Text("Pekerjaan")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Text(":")
                    Text("Mobile Developer")
                }
            }
            .navigationTitle("title_about".localized(identifier: "id.dicoding.CapstoneDicoding"))
        }
    }
}

#Preview {
    ProfileView()
}
