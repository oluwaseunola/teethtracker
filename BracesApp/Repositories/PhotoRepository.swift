//
//  PhotoRepository.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-24.
//

import Foundation
import SwiftUI
import CoreData

final class PhotoRepository {

    
    func saveImage(context: NSManagedObjectContext, data: Data){
        let photo = PhotoItem(context: context)
        photo.data = data
        photo.date = Date()
        photo.id = UUID()
        save(context: context)
    }
    
    private func save(context: NSManagedObjectContext){ 
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
    
    
}
