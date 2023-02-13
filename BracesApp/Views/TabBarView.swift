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
                
                Image(selectedTab == .home ? "Icons-Home-Fill" : "Icons-Home-Outline")
                    .resizable()
                    .scaledToFit()
                    .frame(width:60, height:60)
                
                
            }.padding(.leading,20)
            
            Spacer()
         
            Button {
                selectedTab = .video
            } label: {
                Image(selectedTab == .video ? "Icons-Video-Fill" : "Icons-Video-Outline")
                    .resizable()
                    .scaledToFit()
                    .frame(width:60, height:60)
                
            }
            
            Spacer()
            
            Button {
                selectedTab = .notification
            } label: {
                Image(selectedTab == .notification ? "Icons-Bell-Fill" : "Icons-Bell-Outline")
                    .resizable()
                    .scaledToFit()
                    .frame(width:60, height:60)
                
            }.padding(.trailing,20)
            
        }
        .frame(height:80)
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
    case home, video, notification
}
