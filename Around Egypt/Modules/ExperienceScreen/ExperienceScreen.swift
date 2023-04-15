//
//  SwiftUIView.swift
//  Around Egypt
//
//  Created by Rezk on 15/04/2023.
//

import SwiftUI

struct URLImage : View {
    let urlString : String
    @State var data: Data?
    
    var body : some View {
        if let data = data , let image = UIImage(data: data){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
        } else {
            Image(systemName: "building.columns")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}


struct ExperienceScreen: View {
    @StateObject var viewModel = ExperienceViewModel()
    @EnvironmentObject private var id :ExperienceScreenData
    var body: some View {
        NavigationView {
            Group {
                if let experience = viewModel.experience {
                    VStack {
                        URLImage(urlString: experience.cover_photo)
                        VStack {
                            Text(experience.title)
                                .font(.title)
                            Text(experience.city.name + ", Egypt")
                        }
                        HStack {
                            Text("Likes: \(experience.likes_no)")
                            Spacer()
                            Text("Views: \(experience.views_no)")
                        }
                        .padding()
                        
                        
                        ScrollView {
                            Text(experience.description)
                                .padding()
                        }
                        
                    }
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.fetch(id: id.experienceID)
            }
        }
    }
}

struct ExperienceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceScreen()
    }
}

class ExperienceScreenData: ObservableObject {
    @Published var experienceID: String = ""
}
