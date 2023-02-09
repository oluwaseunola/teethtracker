//
//  Extensions.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-08.
//

import Foundation

extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}
