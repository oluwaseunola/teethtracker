//
//  HomeViewModel.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-26.
//

import Foundation
import SwiftUI
import CoreData

final class HomeViewModel : ObservableObject{
    let repository : HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func deleteImage(context: NSManagedObjectContext, image: PhotoItem){
        repository.deleteImage(context: context, item: image)
    }
}
