//
//  OnboardingView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-10.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @State var currentIndex = 0
    let pages = Page.pages
    
    var body: some View {
        
        
            GeometryReader{ proxy in

                
                TabView(selection: $currentIndex) {
                    ForEach(pages) { page in
                        ZStack{
                            Color("button2").ignoresSafeArea(.all)
                            VStack{
                            
                            Image(page.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:proxy.size.width, height: proxy.size.width)
                            
                            Text(page.text)
                                .padding(.horizontal,20)
                                .frame(width:proxy.size.width-20)
                                .font(.custom(FontManager.light, size: 20))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                
                            
                            
                            
                            
                            if page.id == pages.last?.id{
                                Button {
                                    finish()
                                } label: {
                                    Text("Get started")
                                        .font(.custom(FontManager.bold, size: 15))
                                        .font(.custom(FontManager.bold, size: 15))
                                        .foregroundColor(Color("button1"))
                                        .font(.system(size: 20))
                                        .frame(width:150,height: 50)
                                        .background(Color("background"))
                                        .mask(Capsule())
                                }
                            }else{
                                Button {
                                    next()
                                } label: {
                                    Text("Next")
                                        .font(.custom(FontManager.bold, size: 15))
                                        .foregroundColor(Color("button1"))
                                        .font(.system(size: 20))
                                        .frame(width:150,height: 50)
                                        .background(Color("background"))
                                        .mask(Capsule())
                                }
                            }
                            
                            
                        }}.tag(page.tag)
                        
                    }
                }
                
            }
            
        
        
    }
    
    private func next(){
        currentIndex += 1
    }
    
    private func finish(){
        UserDefaults.standard.set(true, forKey: "isOnboarded")
        dismiss()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
