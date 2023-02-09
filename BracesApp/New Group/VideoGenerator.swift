//
//  VideoGenerator.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-29.
//

import Foundation
import SwiftUI
import AVFoundation
import OSLog
import Photos

class VideoGenerator {
    
    static let shared = VideoGenerator()
    
    private var pixelBuffer : CVPixelBuffer?
    
    private var pixelBuffers : [CVPixelBuffer] = []
    
    private var movieURLS : [URL] = []
    
    private var movieAsset : AVMutableComposition?

    
    private init(){
        
    }
    
    func createVideo(from images: [UIImage], names: [String], duration: Double, completion: @escaping (Result<Bool,Error>)-> Void){
        if !images.isEmpty{
            
                generatePixelBuffers(from: images)
                generateFrames(from: names,duration: duration)
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.mergeClips()
                if let movieAsset =  self?.movieAsset{
                    
                    self?.exportAsset(asset: movieAsset) { result in
                        switch result{
                        case .success(let saved):
                            withAnimation{
                                completion(.success(saved))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
                }
                    
                }
            }
                
            
        }
    }
    
    private func generatePixelBuffers(from images: [UIImage]){
        
        let staticImages = images.map { CIImage(image: $0) }
        
        for image in staticImages {

            
            guard let image else{return}
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                 kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            let width:Int = Int(image.extent.size.width)
            let height:Int = Int(image.extent.size.height)
            
            CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, attrs, &pixelBuffer)
            
            let context = CIContext()
            
            if let pixelBuffer{
                context.render(image, to: pixelBuffer)
                pixelBuffers.append(pixelBuffer)
            }else{
                print("issue with buffer")
                return
            }
            
        }
        
    }
    
    private func generateFrames(from names: [String], duration: Double){
        
        
        for (index, imageName) in names.enumerated(){
            
            guard let outputMovieURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(imageName).mov") else {
//                Make custom error
                return
            }
            
            do {
              try FileManager.default.removeItem(at: outputMovieURL)
            } catch {
              print("Could not remove file \(error.localizedDescription)")
            }
        
            guard let assetwriter = try? AVAssetWriter(outputURL: outputMovieURL, fileType: .mov) else {
              abort()
            }
            
            
            let settingsAssistant = AVOutputSettingsAssistant(preset: .preset1920x1080)?.videoSettings
            let assetWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: settingsAssistant)
            let assetWriterAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: assetWriterInput, sourcePixelBufferAttributes: nil)
            
            
            assetwriter.add(assetWriterInput)
            //begin the session
            assetwriter.startWriting()
            assetwriter.startSession(atSourceTime: CMTime.zero)
            //determine how many frames we need to generate
            let framesPerSecond : Double = 30
            //duration is the number of seconds for the final video
            let totalFrames = duration * framesPerSecond
            var frameCount : Double = 0
            let currentBuffer = pixelBuffers[index]
            while frameCount < totalFrames {
              if assetWriterInput.isReadyForMoreMediaData {
                let frameTime = CMTimeMake(value: Int64(frameCount), timescale: Int32(framesPerSecond))
                //append the contents of the pixelBuffer at the correct time
                assetWriterAdaptor.append(currentBuffer, withPresentationTime: frameTime)
                frameCount+=1
                
              }
            }
            self.movieURLS.append(outputMovieURL)
            
            assetWriterInput.markAsFinished()
            assetwriter.finishWriting { [weak self] in
                self?.pixelBuffer = nil
              //outputMovieURL now has the video
                
              Logger().info("Finished video location: \(outputMovieURL)")
            }
            
        }
        
        
        
    }
    
    private func mergeClips(){
        
        let movie = AVMutableComposition()
        var time : CMTime = .zero
        guard let videoTrack = movie.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else {return}
            
        for url in movieURLS{
            let asset = AVURLAsset(url: url)
            let movieTrack = asset.tracks(withMediaType: .video)[0]
            let movieRange = CMTimeRangeMake(start: CMTime.zero, duration: asset.duration)//3
            do {
                try videoTrack.insertTimeRange(movieRange, of: movieTrack, at: time)
                time = CMTimeAdd(time, asset.duration)
            }
            catch{
            print(error)
            }
            
        }
    
        videoTrack.preferredTransform = VideoHelper.getVideoTransform()
        
        self.movieAsset = movie
    
        }
    
    
    private func exportAsset(asset: AVAsset, completion: @escaping (Result<Bool, Error>)-> Void) {
        let exportPath = NSTemporaryDirectory().appendingFormat("/video.mov")
        let exportURL = URL(fileURLWithPath: exportPath)
    
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.outputURL = exportURL
        exporter?.outputFileType = .mov
        
       

        exporter?.exportAsynchronously(completionHandler: {
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: exportURL)
            }) { saved, error in
                
                if let error {
                    completion(.failure(error))
                    print(error)
                }
                if saved {
                    completion(.success(saved))
                }
            }
        })
        
        cleanUp()
    }
    
    private func cleanUp(){
        pixelBuffers = []
        movieURLS = []
        self.movieAsset = nil
    }
    
    
}

