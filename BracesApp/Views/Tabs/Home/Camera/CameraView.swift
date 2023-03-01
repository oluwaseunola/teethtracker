//
//  CameraView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-10.
//

import SwiftUI

struct CameraView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var viewContext
    @StateObject private var viewModel = CameraViewModel()
    var body: some View {
        
     

        ZStack{
            Color.black.ignoresSafeArea(.all)
            CameraPreview(camera: viewModel)
                .ignoresSafeArea()
            
            VStack{
                
                
                
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            viewModel.showTip = true
                        }
                    }, label: {
                        Image(systemName: "info.circle.fill")
                      .font(.system(size:40))
                      .foregroundColor(Color("background2"))
                    })
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }.padding(.horizontal)
                }
             
                
                Spacer()
                
                if viewModel.isTaken{
                    HStack{
                        
                        Button {
//                            Save image
                            viewModel.saveImage(context: viewContext, data: viewModel.photoData)
                            dismiss()
                        } label: {
                            Text("Save")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .frame(width:70, height: 50)
                                .background(.white)
                                .mask {
                                    Capsule()
                                }
                        }
                        
                        Button {
                            viewModel.retake()
                        } label: {
                            Text("Retake")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .frame(width:100, height: 50)
                                .background(.white)
                                .mask {
                                    Capsule()
                                }
                        }
                        
                        
                    }

                } else {
                    
                    Button {
                        viewModel.takePic()
                    } label: {
                        ZStack{
                            
                            Circle()
                                .foregroundColor(.white)
                                .frame(width:65,height:65)
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width:75,height:75)
                                
                            
                        }
                    }
                }
            }
            
            PopOut(isShown: $viewModel.showTip)
                .offset(y: viewModel.showTip ? 0 : -UIScreen.main.bounds.size.height)

        }
        .onAppear {
            viewModel.repository = PhotoRepository()
            viewModel.check()
        }
        
        
        

    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}


