//
//  MyImagesContainer.swift
//  My Images CD
//
//  Created by Obde Willy on 02/01/23.
//

import Foundation
import CoreData

class MyImagesContainer {
    let persistenteContainer: NSPersistentContainer
    
    init() {
        persistenteContainer = NSPersistentContainer(name: "MyImagesDataModel")
        
        guard let path = persistenteContainer
            .persistentStoreDescriptions
            .first?
            .url?
            .path else {
            fatalError("Couldn't find persistent container")
        }
        
        print("Core Data", path)
        
        persistenteContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
