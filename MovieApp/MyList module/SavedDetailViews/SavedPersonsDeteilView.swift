//
//  SavedPersonsDeteilView.swift
//  MovieApp
//
//  Created by Mac on 05.01.2023.
//

import SwiftUI

struct SavedPersonsDeteilView: View {
    
    @State var person: PersonEntity!
    
    @State var gender = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var personImages: [Images] = []
    @StateObject var personImageapi = personImageApi()
    
//    @State var serieId = 0
//    @State var serieVideos: [Video] = []
//    @StateObject var serieVideoapi = videoApi()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack{
                   HStack {
                       AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.image ?? "")")){ image in
                           image
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(maxWidth: 220, alignment: .center)
                               .cornerRadius(20)
                       } placeholder: {
                           ProgressView()
                       }
           
                       VStack(alignment: .leading, spacing: 10) {
                           Text("Native name: \(person.name ?? "-name-")")
                               .fontWeight(.bold)
                           Text("Gender: \(gender)")
                           Text("Status: \(person.status ?? "-department-")")
                           Text("Popularity: \(person.popularity )")
                           Spacer()
                           
                       }
                       .padding()
                       
                       Spacer()
                       
                   }
                
                Spacer()
                    .frame(height: 15)
                
                Divider()
                
                Spacer()
                    .frame(height: 15)
                
                VStack{
            
                    HStack {
                        NavigationLink {
                            AllFilmsOfPerson(id: Int(person.id), selectedType: .filmes)
                        } label: {
                            Text("Show all films")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThickMaterial)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .dark ? Color("MSCardBackground") : Color.red, lineWidth: 2)
                        )
                    .shadow(color: colorScheme == .dark ? Color("MSCardBackground") : Color.red, radius: 10)
                        
                        NavigationLink {
                            AllSeriesOfPerson(id: Int(person.id), selectedType: .series)
                        } label: {
                            Text("Show all series")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThickMaterial)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .dark ? Color("MSCardBackground") : Color.red, lineWidth: 2)
                        )
                        .shadow(color: colorScheme == .dark ? Color("MSCardBackground") : Color.red, radius: 10)
                    }
                
                }
                
            }
            .onAppear {
                if person.gender == 1 {
                    gender = "woman"
                } else if person.gender == 2 {
                    gender = "man"
                } else {
                    gender = "helicopter"
                }
            }
            
            
            
            VStack {
                if personImages.isEmpty {

                } else {
                    VStack {
                        Text("Photos:")
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top){
                                ForEach(personImages, id: \.self) { (image) in
                                    NavigationLink(destination: ImageDeteilView(image: image), label: {
                                        PersonImageCell(image: image)
                                    })
                                        .frame(width: UIScreen.main.bounds.size.width / 3, height: UIScreen.main.bounds.size.height / 4.5)
                                    
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    
                }
                
            }
            .onAppear {
                personImageapi.getPersonImages(query: "https://api.themoviedb.org/3/person/\(String(describing: person.id))/images?api_key=d736bf662f23f773be5ced737935827d") { model in
                    if let images = model.profiles {
                        personImages = images
                    }
                }
            }
            .padding()
            
            
            
            
            Spacer()
                .frame(height: 15)
            .navigationBarTitle(person.name ?? "-title-", displayMode: .inline)
        }
    }
}

struct SavedPersonsDeteilView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPersonsDeteilView()
    }
}




