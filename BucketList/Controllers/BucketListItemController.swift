//
//  BucketListItemController.swift
//  BucketList
//
//  Created by John Tate on 8/23/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class BucketListItemController {
    
    // Shared Instance (One BucketListItemController to Rule them All)
    static let shared = BucketListItemController()
    
    // Source of Truth
    var bucketList: [BucketListItem] = []
    
    // CRUD
    //Create
    func create(title: String, age: Int, description: String) {
        let bucketListItem = BucketListItem(title: title, age: age, description: description)
        bucketList.append(bucketListItem)
        
        saveToPersistentStore()
    }
    
    // Update
    func update(bucketListItem: BucketListItem, newTitle: String, newAge: Int, newDescription: String) {
        
        bucketListItem.title = newTitle
        bucketListItem.age = newAge
        bucketListItem.description = newDescription
        
        saveToPersistentStore()
    }
    
    // Destroy
    func delete(bucketListItem: BucketListItem) {
        
        // THIS FUNCTION IS ONLY AVAILABLE IF YOU CONFORM TO EQUATABLE
        guard let index = bucketList.index(of: bucketListItem) else { return }
        bucketList.remove(at: index)
        
        saveToPersistentStore()
    }
    
    // MARK = Persistence
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "bucketList.json"
        let documentDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentDirectoryURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(bucketList)
            try data.write(to: fileURL())
        } catch {
            print("There was an error saving to persistent store \(error) \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [BucketListItem] {
        do{
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let bucketList = try decoder.decode([BucketListItem].self, from: data)
            return bucketList
        } catch {
            print("There was an error loading from persistent store \(error) \(error.localizedDescription)")
        }
        return []
    }
    
}
