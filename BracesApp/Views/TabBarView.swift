//
//  TabBarView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab : Tab
    
    var body: some View {
        
        
        //MARK: - TabBar
        
        
        
        
        HStack(alignment:.center){
            
            
            Button {
                selectedTab = .home
            } label: {
                
                Image(systemName: selectedTab == .home ? "house.fill" : "house")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height:40)
                
                
            }
            Rectangle()
                .frame(width:1, height: 50)
            Button {
                selectedTab = .video
            } label: {
                Image(systemName: selectedTab == .video ? "video.fill" : "video")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height:40)
                
            }
            
        }
        .frame(height:100)
        .frame(maxWidth:.infinity)
        .background(.ultraThickMaterial)
        .cornerRadius(15)
        .padding(.horizontal)
        
        
        
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab:.constant(.home))
    }
}

enum Tab {
    case home, video
}
