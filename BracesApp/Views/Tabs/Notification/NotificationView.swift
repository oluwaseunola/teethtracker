//
//  NotificationView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-12.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PhotoItem.date, ascending: true)],
        animation: .default) private var events: FetchedResults<Event>
    
    var body: some View {
        VStack{
            
            Text("Upcoming Events")
                .padding(.bottom,20)
                .font(.custom(FontManager.bold, size: 30))
            
            if !events.isEmpty{
                
                List(events, id:\.id) { event in
                    
                
                }
                .frame(maxWidth:.infinity)
                .frame(height:500)
                .padding(.horizontal,30)
            }
            else {
                
                ScrollView{
                    Text("No upcoming events")
                }
                .frame(maxWidth:.infinity)
                .frame(height:500)
                .padding(.horizontal,30)
                
                
            }
            
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
