//
//  personDeteilView.swift
//  MovieApp
//
//  Created by Mac on 26.12.2022.
//

import SwiftUI

extension DeteilView {
    
    //MARK: - personDeteilView
    var personDeteilView: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.profile_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Native name: \(person.original_name ?? "-name-")")
                        .fontWeight(.bold)
                    Text("Gender: \(gender)")
                    Text("Status: \(person.known_for_department ?? "-department-")")
                    Text("Popularity: \(person.popularity ?? 0)")
                    Spacer()
                    
                    HStack{
                        Spacer()
                        VStack {
                            Spacer()
                            
                            ZStack{
                                Button {
                                    
                                    if vmPerson.savedEntities.contains(where: { $0.name == person.name } ) {
                                            alertTitle = "Attention"
                                            alertMessage = "this person is already added"
                                            showingAlert = true
                                        } else {
                                            alertTitle = "Congratulations"
                                            alertMessage = "you add this person"
                                            showingAlert = true
                                            vmPerson.addPerson(
                                                name: person.name ?? "",
                                                image: person.profile_path ?? "",
                                                status: person.media_type ?? "",
                                                popularity: person.popularity ?? 0,
                                                gender: person.gender ?? 0,
                                                id: person.id ?? 0
                                            )
                                            
                                        }
                                    
                                    
                                } label: {
                                    Circle()
                                        .frame(width: 50, height: 50)
                                }
                                .foregroundColor(Color.red)
                                .alert(isPresented:$showingAlert) {
                                    Alert(
                                        title: Text(alertTitle),
                                        message: Text(alertMessage),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.primary)
                                    .frame(width: 40, height: 40)
                            }
                            
                            Spacer()
                                .frame(height: 10)
                        }
                        
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .padding()
            
            Spacer()
                .frame(height: 15)
            
            Divider()
            
            
            VStack {
                if knownFor.isEmpty {
                    
                } else {
                    VStack {
                        Text("Known for projects:")
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top){
                                ForEach(knownFor, id: \.id) { (knownForItem) in
                                    NavigationLink(destination: KnownForDeteilView(knownForItem: knownForItem), label: {
                                        PersonKnownForMovieCell(knownFor: knownForItem)
                                    })
                                        .frame(width: UIScreen.main.bounds.size.width / 1.3, height: UIScreen.main.bounds.size.height / 3.5)
                                        .background(.secondary)
                                        .cornerRadius(20)
                                    
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color("MSCardBackground"))
                    .cornerRadius(20)
                    
                }
                
            }
            .onAppear {
                knownFor = person.known_for ?? []
                if person.gender == 1 {
                    gender = "woman"
                } else if person.gender == 2 {
                    gender = "man"
                } else {
                    gender = "helicopter"
                }
                    
            }
            .padding()
            
            
            Spacer()
                .frame(height: 15)
            
            VStack{
        
                HStack {
                    NavigationLink {
                        AllFilmsOfPerson(id: person.id ?? 2, selectedType: .filmes)
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
                        AllSeriesOfPerson(id: person.id ?? 2, selectedType: .series)
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
            
            Spacer()
                .frame(height: 15)
            
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
                if let personID = person.id {
                    personImageapi.getPersonImages(query: "https://api.themoviedb.org/3/person/\(String(describing: personID))/images?api_key=d736bf662f23f773be5ced737935827d") { model in
                        if let images = model.profiles {
                            personImages = images
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
                .frame(height: 15)
            
        }
        .navigationBarTitle(person.name ?? "-name-", displayMode: .inline)
    }
    
}



// MARK: - person known for movie cell

struct PersonKnownForMovieCell: View {
    
    var knownFor: KnownFor
    @State var title = ""
    @State var release = ""
    
    var body: some View {
        VStack {
            HStack {
                
                ZStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(knownFor.backdrop_path ?? "")")){ image in
                        image
                            .resizable()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .blur(radius: 6)
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(knownFor.poster_path ?? "")")){ image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding()
                }
                
                
                
                VStack{
                    Text("\(title)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Popularity:")
                        Text("\(knownFor.popularity ?? 0)")
                        Spacer()
                        Text("Release")
                        Text("\(release)")
                        Spacer()
                        Text("Type: \(knownFor.media_type ?? "")")
                    }
                }
                .padding()
                .foregroundColor(.white)
            }
        }
        .onAppear {
            if knownFor.media_type == "tv" {
                title = "TVSERIE"
                release = "RELESEDATE"
            } else if knownFor.media_type == "movie" {
                title = knownFor.title ?? ""
                release = knownFor.release_date ?? ""
            }
        }
    }
}


// MARK: - person image movie cell

struct PersonImageCell: View {
    
    var image: Images
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(image.file_path ?? "")")){ image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(10)
        }
    }
    
}
