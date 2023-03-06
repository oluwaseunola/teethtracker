//
//  NotificationView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-12.
//

import SwiftUI
import EventKit

struct NotificationView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    @State var showEventEditor = false
    
    var body: some View {
        VStack{
            
            Text("Create Reminders.")
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                .font(.custom(FontManager.bold, size: 40))
                .frame(maxWidth:.infinity, alignment: .leading)
                .offset(y:20)
                
                Image("Reminder")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
                Text("Add a reminder to your calendar app")
                    .font(.custom(FontManager.regular, size: 15))
                
            Button {
                showEventEditor.toggle()
            } label: {
                Text("Add")
                    .font(.custom(FontManager.bold, size: 15))
                    .font(.custom(FontManager.bold, size: 15))
                    .foregroundColor(Color("button1"))
                    .font(.system(size: 20))
                    .frame(width:150,height: 50)
                    .background(Color("background"))
                    .mask(Capsule())
            }

            
            Spacer()
            
        }
        .padding(.horizontal,20).sheet(isPresented: $showEventEditor) {
            EventEditView(eventStore: EKEventStore(), event: nil)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
