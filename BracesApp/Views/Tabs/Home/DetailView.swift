//
//  DetailView.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-24.
//

import SwiftUI

struct DetailView: View {
    var detail : Image
    var body: some View {
        
       GeometryReader{ geometry in
           detail
            .resizable().aspectRatio(contentMode: .fit).frame(width:geometry.size.width,height: geometry.size.height)}
    }
}


