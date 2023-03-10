//
//  VideoView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI

struct VideoView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = VideoViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoItem.date, ascending: true)],
        animation: .default) private var items: FetchedResults<PhotoItem>
    
    @State var sliderValue : Double = 0.1
    
    var body: some View {
        
        VStack{
            VStack{
                Text("Create Your")
                    .padding(EdgeInsets(top: 20, leading:20, bottom:0 , trailing: 0))
                    .font(.custom(FontManager.bold, size: 40))
                    .frame(maxWidth:.infinity, alignment: .leading)
                Text("Masterpiece.")
                    .padding(EdgeInsets(top: -50, leading:20, bottom:0 , trailing: 0))
                    .font(.custom(FontManager.bold, size: 40))
                    .frame(maxWidth:.infinity, alignment: .leading)
                
            }.offset(y:20)
            
            
        Spacer()
            switch viewModel.saveState {
            case .idle :
                Image(colorScheme == .light ? "Video" : "VideoDark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .saving :
                VStack{
                    Text("Saving Your Smile")
                        .font(.custom(FontManager.bold, size: 11))
                    ProgressView()
                }
                .frame(width:150, height: 100)
                .background(.ultraThickMaterial)
                .cornerRadius(20)
                .padding(.bottom)
            case .saved :
                
                VStack{
                Image(systemName: "checkmark.circle")
                        .font(.system(size:50))
                        .foregroundColor(.green)
                        
                    Text("Video saved to camera roll")
                        .font(.custom(FontManager.bold, size: 12))
        
                }
                .padding(.bottom)

            case .error:
                Image(systemName: "x.circle")
                    .font(.system(size:50))
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            Text("Choose duration of each image: \(String(format:"%.1f", sliderValue)) seconds")
                .font(.custom(FontManager.regular, size: 15))
            
            Slider(value: $sliderValue, in: 0.1...5)
        
            
            let images = items.map{ PhotoItem -> UIImage in
                if let data = PhotoItem.data{
                    if let image =  UIImage(data: data) {
                        return image
                    }
                }
                return UIImage()
            }
            
            let names = items.map{ photoItem -> String in
                if let id = photoItem.id{
                    return id.uuidString
                }
                return String()
            }
            
            Button {
                viewModel.createVideo(from: images, names: names, duration: sliderValue)
                
            } label: {
                Text("Create Video")
                    .font(.custom(FontManager.bold, size: 15))
                    .font(.custom(FontManager.bold, size: 15))
                    .foregroundColor(Color("button1"))
                    .font(.system(size: 20))
                    .frame(width:150,height: 50)
                    .background(Color("background"))
                    .mask(Capsule())
            }.disabled(viewModel.saveState == .idle || viewModel.saveState == .saved ? false : true )
                .opacity(viewModel.saveState == .idle || viewModel.saveState == .saved ? 1 : 0.5 )
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 100, trailing: 0))
            
            Spacer()
            
        }
        .padding(.horizontal,20)
        
        
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
