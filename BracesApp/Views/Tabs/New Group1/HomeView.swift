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
    @State private var currentImage : Image = Image(systemName: "person")
    @State private var imagePicked = "Delete"
    
    var body: some View {
        
GeometryReader{ geometry in
    
    VStack{
            
            HStack{
                Spacer()
                Button {
                    showCamera = true
            } label: {
                Image(systemName: "camera.fill")
                    .font(.system(size: 40))
                
            }
                
            }
            .frame(maxWidth:.infinity)
            .frame(height:100)
            .padding(.horizontal)
            .background(.ultraThickMaterial)
            
        
        if !items.isEmpty {
            
            ScrollView{
               
                    LazyVGrid(columns: gridRows, spacing: 10) {
                    
                        ForEach(items) { item in
                            
                            VStack{
                                HStack{
                                    Spacer()
                                    Menu {
                                        Button {
//                                          Delete Item
                                            viewModel.deleteImage(context: viewContext, image: item)
                                            
                                        } label: {
                                            Text("Delete")
                                        }

                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .font(.system(size: 25))
                                    }

                                }
                                VStack{
                                    
                                
                                
                                if let imageData = item.data, let image = UIImage(data: imageData) {
                                    Image(uiImage: image).resizable().aspectRatio(contentMode: .fit).frame(width:geometry.size.width/3.3,height: geometry.size.width/3.3).cornerRadius(15)
                                }
                                
                                if let itemDate = item.date{Text(itemFormatter.string(from: itemDate))}
                                
                            }
                                .onTapGesture {
                                if let imageData = item.data, let image = UIImage(data: imageData){
                                    currentImage = Image(uiImage: image)
                                }
                                
                                showDetial = true
                                
                            }
                        }
                        }
                        
                }.padding(.horizontal,10)
                 
                
            }
            .frame(maxWidth:.infinity)
            } else{
                Spacer()
                Text("No photos, take a photo to get started.")
                Spacer()
            }
        }
    .fullScreenCover(isPresented: $showCamera){
        CameraView().environment(\.managedObjectContext, viewContext)
    }
    .sheet(isPresented: $showDetial) {
            DetailView(detail: currentImage)
    }

    
}
        
        
    }
}

