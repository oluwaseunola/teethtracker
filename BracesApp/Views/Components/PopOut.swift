//
//  PopOut.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-13.
//

import SwiftUI

struct PopOut: View {
    @Binding var isShown : Bool
    
    var body: some View {
        
    
          VStack{
              
              HStack{
                  Spacer()
                  
                  Button {
                      withAnimation(.spring()){
                          isShown = false
                      }
                  } label: {
                      Image(systemName: "xmark.circle.fill")
                          .font(.system(size: 20))
                          .foregroundColor(Color("background"))
                  }.padding(.horizontal)
              }.offset(y: -30)
              
            
              Text("To ensure best results, use the masked area and take your selfie in a well lit area!")
                  .multilineTextAlignment(.center)
            .font(.custom(FontManager.bold, size: 13))
            .padding(.horizontal)
            
              
          }
          .frame(width: 300, height: 150)
                .background(Color("button2"))
                .cornerRadius(15)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onEnded({ value in
                                        
                                        if value.translation.height < 0 {
                                            withAnimation(.spring()){
                                                isShown = false
                                            }
                                        }
                                    }))
                .opacity( isShown ? 1 : 0)
                
            
        
            
        
    }
}

struct PopOut_Previews: PreviewProvider {
    static var previews: some View {
        PopOut(isShown: .constant(true))
    }
}
