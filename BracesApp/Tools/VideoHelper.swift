//
//  VideoHelper.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-06.
//

import Foundation
import AVFoundation
import SwiftUI

class VideoHelper {
    
    static private var orientation = UIDevice.current.orientation
    
    static func getVideoTransform() -> CGAffineTransform {
            switch orientation {
                case .portrait:
                    return CGAffineTransform(rotationAngle: 90.degreesToRadians)
                case .portraitUpsideDown:
                    return CGAffineTransform(rotationAngle: 180)
                case .landscapeLeft:
                    return CGAffineTransform(rotationAngle: 0.degreesToRadians)
                case .landscapeRight:
                    return CGAffineTransform(rotationAngle: 180.degreesToRadians)
                default:
                    return CGAffineTransform(rotationAngle: 90.degreesToRadians)
            }
        }

   
}
