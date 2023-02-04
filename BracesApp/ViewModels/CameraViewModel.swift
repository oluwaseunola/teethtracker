//
//  CameraViewModel.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-24.
//

import Foundation
import AVFoundation
import SwiftUI
import CoreData

final class CameraViewModel : NSObject, ObservableObject{
    
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview = AVCaptureVideoPreviewLayer()
    @Published var isSaved = false
    @Published var photoData = Data()
    
    var repository : PhotoRepository?
    
     func check(){
         
         switch AVCaptureDevice.authorizationStatus(for: .video){
             
         case .notDetermined:
             AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
                 if status{
                     DispatchQueue.main.async {
                         self?.setup()
                     }
                 }
             }
         case .restricted:
             return
         case .denied:
             alert.toggle()
         case .authorized:
             DispatchQueue.main.async { [weak self] in
                 self?.setup()
             }
         @unknown default:
             return
         }
        
    }
    
    func setup(){
        
        do{
            self.session.beginConfiguration()
            
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front){
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }

            }
            
            if session.canAddOutput(output){
                session.addOutput(output)
            }
            
            session.commitConfiguration()
}
        catch{
            print(error)
        }
        
    }
    
    func takePic(){

            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            self.output.capturePhoto(with: settings, delegate: self)
            
        DispatchQueue.main.async{
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                                self.session.stopRunning()
                            }
                
                withAnimation {
                    self.isTaken = true
                }
            
        }

    }
    
    func retake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = false
                }
            }
        }
    }
    
    func saveImage(context: NSManagedObjectContext, data: Data){
        repository?.saveImage(context: context, data: data)
    }
    
}

extension CameraViewModel : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {return}
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        
        self.photoData = imageData
        
    }
    
    
}
