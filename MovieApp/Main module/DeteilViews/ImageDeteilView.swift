//
//  ImageDeteilView.swift
//  MovieApp
//
//  Created by Mac on 09.01.2023.
//

import SwiftUI

struct ImageDeteilView: View {
    
    var image: Images
    
    var body: some View {
        
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(image.file_path ?? "")")){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
        } placeholder: {
            ProgressView()
        }
        .padding()
        
    }
}

