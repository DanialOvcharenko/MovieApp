//
//  MyAccountView.swift
//  MovieApp
//
//  Created by Mac on 30.11.2022.
//

import SwiftUI

struct MyAccountView: View {
    
    @State var genresList: [AllGenres] = []
    
    @State var nameEntity: NameEntity!
    
    @StateObject var vm = CoreDataAccountViewModel()
    @StateObject var vmName = CoreDataNameViewModel()
    
    @StateObject var vmFM = FileManagerViewModel()
    
    @StateObject private var Api = genresApi()
    
    @State private var genresQuerry = "https://api.themoviedb.org/3/genre/movie/list?api_key=d736bf662f23f773be5ced737935827d&language=en-US"
    
    @State var textFieldName: String = ""
    @State var textFieldSurname: String = ""
    @State var textFieldAge: String = ""
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var age: String = ""
    
    @State var showSettings: Bool = false
    
    @State var showImagePicker = false
    @State var image: UIImage?
    
    @State var showingAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
        
    var body: some View {
        
        NavigationView {
            
            VStack{
                if showSettings == false {
                    Account
                } else if showSettings == true {
                    Settings
                }
            }
            
            
            .toolbar {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.circle.fill")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}



extension MyAccountView {
    
    

    private var Account: some View {
        VStack(spacing: 20) {
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                
                VStack(alignment: .leading) {
                    if name == "" && surname == "" && age == "" {
                        Text("name surname")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        Text("age")
                    } else if name == "" && surname == "" {
                        Text("name surname")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        Text("Age: \(age)")
                    } else if age == "" {
                        Text("\(name) \(surname)")
                            .fontWeight(.bold)
                        Text("age")
                    } else {
                        Text("\(name) \(surname)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        Text("Age: \(age)")
                    }
                }
                
                Spacer()
                
                VStack {
                    if let image = vmFM.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                    } else {
                        Image(systemName: "person")
                            .font(.system(size: 50))
                            .padding()
                            .foregroundColor(.primary)
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.primary, lineWidth: 3))
                
            }
            .padding()
            
            Divider()
            
            VStack {
                
                Text("Favourite genres")
                    .font(.title2)
                    .fontWeight(.bold)
            
                
                if vm.savedEntities.isEmpty {
                    Text("Favourite genres list is empty")
                        .foregroundColor(.gray)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .center){
                            ForEach(vm.savedEntities, id: \.id) { (genre) in
                                SavedGenreCell(genre: genre)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            
            Divider()
            
            Spacer()
        }
        .onAppear {
            if vmName.savedEntities.isEmpty {
                name = "Name"
                surname = "Surname"
                age = "Age"
            } else {
                nameEntity = vmName.savedEntities.first
                
                name = nameEntity.name ?? "none"
                surname = nameEntity.surname ?? "none"
                age = String(nameEntity.age)
            }
        }
        
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarTitle("Account", displayMode: .inline)
    }
    
    
    
    
    
    private var Settings: some View {
        
            VStack(spacing: 20) {
                
                Spacer()
                    .frame(height: 20)
                
                VStack{
                    
                    ZStack {
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                } else {
                                    Image(systemName: "person")
                                        .font(.system(size: 70))
                                        .padding()
                                        .foregroundColor(.primary)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 70).stroke(Color.primary, lineWidth: 3))
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    if textFieldName.isEmpty || textFieldSurname.isEmpty || textFieldAge.isEmpty {
                                        
                                        alertTitle = "Attention"
                                        alertMessage = "Not all fields are filled"
                                        showingAlert = true
                                        
                                    } else if !textFieldAge.isNumeric || Int(textFieldAge) ?? 0 < 6 || Int(textFieldAge) ?? 0 > 150 {
                                        
                                        alertTitle = "Attention"
                                        alertMessage = "Age is not valid format. Try to add your real age (6-150)"
                                        showingAlert = true
                                        
                                    } else {
                                        
                                        if !vmName.savedEntities.isEmpty {
                                            vmName.deleteName()
                                        }
                                        
                                        vmName.addName(name: textFieldName, surname: textFieldSurname, age: Int32(textFieldAge) ?? 0)
                                        
                                        vmFM.deleteImage()
                                        
                                        vmFM.image = self.image
                                        vmFM.saveImage()
                                        
                                        alertTitle = "Cool"
                                        alertMessage = "Saved"
                                        showingAlert = true
                                        
                                        showSettings.toggle()
                                    }
                                } label: {
                                    Text("save")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal)
                                        .padding(7)
                                        .background(Color.red)
                                        .cornerRadius(20)
                                        .padding(2)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.secondary, lineWidth: 2)
                                )
                                .alert(isPresented:$showingAlert) {
                                    Alert(
                                        title: Text(alertTitle),
                                        message: Text(alertMessage),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                                Spacer()
                                    .frame(width: 15)
                            }
                        }
                        
                    }
                    
                    
                    VStack {
                        
                        HStack {
                            
                            VStack(alignment: .trailing, spacing: 16) {
                                Text("Name")
                                Text("Surname")
                                Text("Age")
                            }
                            .padding(.top, 1)
                            
                            VStack{
                                TextField(name == "" ? "type your name" : name, text: $textFieldName)
                                    .padding(3)
                                    .padding(.horizontal, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                                TextField(surname == "" ? "type your surname" : surname, text: $textFieldSurname)
                                    .padding(3)
                                    .padding(.horizontal, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                                TextField(age == "" ? "type your age" : age, text: $textFieldAge)
                                    .padding(3)
                                    .padding(.horizontal, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                            }
                            .onAppear{
                                textFieldName = name
                                textFieldSurname = surname
                                textFieldAge = age
                            }
                        }
                        
                    }
                    .padding()
                    
                    Text("Genres list")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("choose your favourite genres")
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top){
                            ForEach(genresList, id: \.id) { (genre) in
                                Button {
                                    if vm.savedEntities.contains(where: { $0.genre == genre.name } ) {
                                        
                                    } else {
                                        vm.addGenre(genre: genre.name ?? "-genreName-")
                                    }
                                } label: {
                                    GenreCell(genre: genre)
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 5)
                                
                            }
                        }
                        .padding(.leading)
                    }
                    .onAppear {
                        Api.getGenres(query: genresQuerry) { model in
                            genresList = model.genres
                        }
                    }
                    .background(Color("GenreBackground"))
                    
                    Text("Favourite genres list (editable)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    
                    if vm.savedEntities.isEmpty {
                        Text("Favourite genres list is empty")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(vm.savedEntities, id: \.id) { (genre) in
                                SavedGenreCell(genre: genre)
                            }
                            .onDelete(perform: vm.deleteGenre)
                        }
                        .listStyle(.plain)
                        
                    }
                    
                }.onAppear {
                    self.image = vmFM.image
                }
                
                Divider()
                
                Spacer()
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton()
            )
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
                    .ignoresSafeArea()
        }
        
    }
    
}




// MARK: - Genre cell

struct GenreCell: View {
    
    var genre: AllGenres
    
    var body: some View {
        VStack {
            Text(genre.name ?? "-genreName-")
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(7)
                .background(Color("MSCardBackground"))
                .cornerRadius(15)
        }
    }
}

// MARK: - Genre cell

struct SavedGenreCell: View {
    
    var genre: GenreEntity
    
    var body: some View {
        VStack {
            Text(genre.genre ?? "-genreName-")
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(7)
                .background(Color("MSCardBackground"))
                .cornerRadius(15)
                
        }
    }
}


// MARK: - ImagePicker

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @StateObject var vmFM = FileManagerViewModel()
    
    private let controller = UIImagePickerController()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePicker
        
        init(parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}


//MARK: -
//MARK: -
//MARK: -

// MARK: - LocalFileManager

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            print("Error getting image.")
            return
        }
        
        
        do {
            try data.write(to: path)
            print("Success saving!")
        } catch let error {
            print("Error saving! \(error)")
        }
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting path.")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Successfully deleted.")
        } catch let error {
            print("Error deleting. \(error)")
        }
    }
        
        
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
        
    }
        
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg") else {
                    print("Error getting path.")
                    return nil
                }
        return path
    }
    
}


// MARK: - FileManagerViewModel

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "myImage"
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromFileManager()
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        manager.deleteImage(name: imageName)
    }
    
}






//MARK: - Extension for checking age

extension String {
   var isNumeric: Bool {
     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
   }
}
