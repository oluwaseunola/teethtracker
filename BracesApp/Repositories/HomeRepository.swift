//
//  HomeRepository.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-01-26.
//

import Foundation
import SwiftUI
import CoreData


final class HomeRepository {
    
    func deleteImage(context: NSManagedObjectContext, item: PhotoItem){
        context.delete(item)
        
        do {
           try context.save()
        }
        catch{
            print(error)
        }
        
    }
}
