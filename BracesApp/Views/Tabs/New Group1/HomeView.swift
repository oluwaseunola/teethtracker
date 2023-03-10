//
//  HomeView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel : HomeViewModel = HomeViewModel(repository: HomeRepository())
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoItem.date, ascending: true)],
        animation: .default) private var items: FetchedResults<PhotoItem>
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    private var gridRows = Array(repeating: GridItem(spacing:10), count: 3)
    @State private var showCamera = false
    @State private var showDetial = false
    @State private var currentItem : DetailImage?
    @State private var imagePicked = "Delete"
    
    var body: some View {
        
GeometryReader{ geometry in
    
    VStack{
            
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200,height: 200)
                Spacer()
                Button {
                    showCamera = true
            } label: {
                
                Image(systemName: "camera.fill")
                    .foregroundColor(Color("background"))
                    .font(.system(size: 20))
                    .frame(width:60,height: 60)
                    .background(Color("button1"))
                    .mask(Circle())
                
            }
                
            }
            .frame(maxWidth:.infinity)
            .frame(height:100)
            .padding(.horizontal)
            .background(
                colorScheme == .light ? Color("background2") : Color("background")
            )
            
        
        if !items.isEmpty {
            
            ScrollView{
               
                    LazyVGrid(columns: gridRows, spacing: 10) {
                    
                        ForEach(items) { item in
                            
                            VStack{

                                if let imageData = item.data, let image = UIImage(data: imageData) {
                                    Image(uiImage: image).resizable().aspectRatio(contentMode: .fill).frame(width:geometry.size.width/3.3,height: geometry.size.width/3.3).cornerRadius(15)
                                        .contextMenu {
                                            
                                            if let itemDate = item.date{Text(itemFormatter.string(from: itemDate))}
                                            
                                            Button(role:.destructive) {
                                                viewModel.deleteImage(context: viewContext, image: item)
                                                
                                            } label: {
                                                Label {
                                                    Text("Delete Image")
                                                } icon: {
                                                    Image(systemName: "trash")
                                                }

                                            }
         
                                        }
                                        .onTapGesture {
                                            if let imageData = item.data, let image = UIImage(data: imageData){
                                                currentItem = DetailImage(image: Image(uiImage: image))
                                            }
                                        }
                                }
                                
                        }
                        }
                        
                }.padding(.horizontal,10)
                 
                
            }
            .frame(maxWidth:.infinity)
            } else{
                Spacer()
                Text("No photos, take a photo to get started!")
                    .font(.custom(FontManager.bold, size: 19))
                Spacer()
            }
        }
    .fullScreenCover(isPresented: $showCamera){
        CameraView().environment(\.managedObjectContext, viewContext)
    }
    .sheet(item: $currentItem) { item in
        DetailView(detail: item.image)
    }
}
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
