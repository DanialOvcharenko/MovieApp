//
//  KnownForDeteilView.swift
//  MovieApp
//
//  Created by Mac on 25.12.2022.
//

import SwiftUI

struct KnownForDeteilView: View {
    
    @State var knownForItem: KnownFor!
    @State var originalTitle = ""
    @State var title = ""
    @State var release = ""
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack{

                Text("Original title: \(originalTitle)")
                    .fontWeight(.bold)

                ZStack{
                    ZStack{
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(knownForItem.backdrop_path ?? "")")){ image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .blur(radius: 7)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        ZStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(knownForItem.poster_path ?? "")")){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 220, alignment: .center)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            if knownForItem.media_type == "movie" {
                                HStack{
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        ZStack{

                                            NavigationLink(destination: searchMovieFromKnown(movieName: knownForItem.title ?? ""), label: {
                                                ZStack{
                                                    Circle()
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(Color.red)
                                                    
                                                    Image(systemName: "magnifyingglass")
                                                        .font(.system(size: 30))
                                                        .foregroundColor(.primary)
                                                        .frame(width: 40, height: 40)
                                                }
                                            })
                                            
                                            
                                        }
                                        
                                        Spacer()
                                            .frame(height: 10)
                                    }
                                }
                            }
                        
                        }
                        .padding()
                    }
                }
                
                VStack{
                    Text("Overview")
                        .fontWeight(.bold)
                    Text(knownForItem.overview ?? "")
                }
                .padding()
                
                Divider()
                
                VStack {
                    
                    VStack {
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text("\(knownForItem.vote_average ?? 0) by \(knownForItem.vote_count ?? 0) voters")
                        }
                        Divider()
                        Text("Date of release: \(release)")
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Original language: \(knownForItem.original_language ?? "none")")
                        Divider()
                        Text("Popularity: \(knownForItem.popularity ?? 0)")
                        
                    }
                    
                }
                
                
            }
            .padding(.bottom)
            .navigationBarTitle(title, displayMode: .inline)
        }
        .onAppear {
            if knownForItem.media_type == "tv" {
                title = "TVSERIE"
                release = "RELESEDATE"
                originalTitle = "TVSERIE"
            } else if knownForItem.media_type == "movie" {
                title = knownForItem.title ?? ""
                release = knownForItem.release_date ?? ""
                originalTitle = knownForItem.original_title ?? ""
            }
        }
    }
}

struct KnownForDeteilView_Previews: PreviewProvider {
    static var previews: some View {
        KnownForDeteilView()
    }
}
