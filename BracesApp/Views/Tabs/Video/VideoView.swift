//
//  VideoView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI

struct VideoView: View {
    @StateObject var viewModel = VideoViewModel()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoItem.date, ascending: true)],
        animation: .default) private var items: FetchedResults<PhotoItem>
    
    @State var sliderValue : Double = 0.1
    
    var body: some View {
        
        VStack{
            
            
            switch viewModel.saveState {
            case .idle :
                EmptyView()
            case .saving :
                VStack{
                    Text("Saving Video")
                    ProgressView()
                }
                .frame(width:150, height: 100)
                .background(.ultraThickMaterial)
                .cornerRadius(20)
                .padding(.bottom)
            case .saved :
                Image(systemName: "checkmark.circle")
                    .font(.system(size:50))
                    .foregroundColor(.green)
                    .padding(.bottom)
            case .error:
                Image(systemName: "x.circle")
                    .font(.system(size:50))
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
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
                Text("create video")
            }
            
            Slider(value: $sliderValue, in: 0.1...5) {
                
            }
            
            Text("Choose duration time: \(sliderValue) seconds")
            
        }
        .padding(.horizontal,20)
        
        
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
