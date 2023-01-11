//
//  PersonsMainView.swift
//  MovieApp
//
//  Created by Mac on 25.12.2022.
//

import SwiftUI

struct PersonsMainView: View {
    
    @State var topRatedPersons: [Person] = []
    @State var popularPersons: [Person] = []
    
    @StateObject private var api = personApi()
    
    @State var selectedType: SelectedType
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                Text("Top Rated")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(topRatedPersons, id: \.id) { (person) in
                            NavigationLink(destination: DeteilView(person: person, selectedType: selectedType), label: {
                                TopRatedPersonCell(person: person)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 1.6, height: UIScreen.main.bounds.size.height / 2.2)
                                .background(Color("MSCardBackground"))
                                .cornerRadius(20)
                            
                        }
                    }
                }
                .onAppear {
                    api.getPerson(query: "https://api.themoviedb.org/3/trending/person/week?api_key=d736bf662f23f773be5ced737935827d") { model in
                        topRatedPersons = model.persons
                    }
                }
                .shadow(color: Color.gray, radius: 15)
            }
            .padding(.horizontal)
            
            
            
            VStack {
                Text("Popular")
                    .font(.system(size: 36))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top){
                        ForEach(popularPersons, id: \.id) { (person) in
                            NavigationLink(destination: DeteilView(person: person, selectedType: selectedType), label: {
                                PopularPersonCell(person: person)
                                })
                                .frame(width: UIScreen.main.bounds.size.width / 1.8, height: UIScreen.main.bounds.size.height / 2.4)
                            
                        }
                    }
                }
                .onAppear {
                    api.getPerson(query: "https://api.themoviedb.org/3/person/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1") { model in
                        popularPersons = model.persons
                    }
                }
                .shadow(color: Color.gray, radius: 15)
            }
            .padding(.horizontal)
            
            
        }
    }
}

struct PersonsMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PersonsMainView(selectedType: .persons)
                .padding(.vertical)
                .navigationBarHidden(true)
        }
    }
}



// MARK: - TopRated person cell

struct TopRatedPersonCell: View {
    
    var person: Person
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.profile_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, alignment: .center)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            Text(person.name ?? "")
                .foregroundColor(.black)
                .font(.system(size: 20.0))
                .fontWeight(.bold)
                .padding(.top, 10)
                .lineLimit(1)
            
        }
    }
}


// MARK: - Popular person cell

struct PopularPersonCell: View {
    
    var person: Person
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(person.profile_path ?? "")")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            Text(person.name ?? "")
                .foregroundColor(.primary)
                .font(.system(size: 20.0))
                .fontWeight(.bold)
                .padding(.top, 10)
                .lineLimit(1)
            
        }
    }
}
