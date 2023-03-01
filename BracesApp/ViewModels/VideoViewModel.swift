//
//  VideoViewModel.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-31.
//

import Foundation
import SwiftUI

enum SaveState {
    case idle,saving, saved, error
}

final class VideoViewModel : ObservableObject {
    
    @Published var saveState : SaveState = .idle
    
    func createVideo(from images: [UIImage], names: [String], duration: Double){
        
        if !images.isEmpty{
            saveState = .saving
            VideoGenerator.shared.createVideo(from: images, names: names, duration: duration) { saved in
                DispatchQueue.main.async{ [weak self] in
                    switch saved {
                    case .success(_):
                        withAnimation(.interpolatingSpring(stiffness: 170, damping: 15).delay(2.5)){self?.saveState = .saved}
                    case .failure(_):
                        self?.saveState = .error
                    }
                }
            }}
        
    }
    
    
    
    
}
