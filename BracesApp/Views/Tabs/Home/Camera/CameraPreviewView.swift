import Foundation
import SwiftUI
import AVFoundation


struct CameraPreview : UIViewRepresentable {
    
    @ObservedObject var camera : CameraViewModel

   
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        camera.preview.session = camera.session
        camera.preview.frame = view.frame
        
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        
            camera.session.startRunning()
        
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}
