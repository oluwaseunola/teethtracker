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
            
            Text("Create Reminders")
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                .font(.custom(FontManager.bold, size: 30))
                .frame(maxWidth:.infinity, alignment: .leading)
            Spacer()
                
                Text("Add a reminder to your calendar!")
                    .font(.custom(FontManager.regular, size: 20))
                
            Button {
                showEventEditor.toggle()
            } label: {
                Text("Add Reminder")
                    .font(.custom(FontManager.bold, size: 15))
                    .font(.custom(FontManager.bold, size: 15))
                    .foregroundColor(Color("button1"))
                    .font(.system(size: 20))
                    .frame(width:150,height: 50)
                    .background(Color("background"))
                    .mask(Capsule())
            }

            
            Spacer()
            
        }.sheet(isPresented: $showEventEditor) {
            EventEditView(eventStore: EKEventStore(), event: nil)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
