//
//  ContentView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI
import CoreData

struct RootView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selectedTab : Tab = .home
    @State var isOnboarded = !UserDefaults.standard.bool(forKey: "isOnboarded")
    
    var body: some View {
        
        ZStack{
            
            switch selectedTab {
            case .home:
                HomeView()
            case .video:
                VideoView()
            case .notification:
                NotificationView()
            }
            
            VStack{
                
                Spacer()
                
                TabBarView(selectedTab: $selectedTab)
                
            }
            
        }.fullScreenCover(isPresented: $isOnboarded) {
            OnboardingView()
        }
         
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
