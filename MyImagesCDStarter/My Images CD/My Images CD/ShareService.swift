//
//  ShareService.swift
//  My Images CD
//
//  Created by Obde Willy on 05/01/23.
//

import Foundation

struct CodableImage: Codable, Equatable {
    let comment: String
    let dateTaken: Date
    let id: String
    let name: String
    let receivedFrom: String
}

class ShareService: ObservableObject {
    static let ext = "myimg"
    
    func saveMyImage(_ codableImage: CodableImage) {
        let fileName = "\(codableImage.id).\(Self.ext)"
        
        do {
            let data = try JSONEncoder().encode(codableImage)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveJson(jsonString, fileName: fileName)
        } catch {
            print("Couldn't encode data")
        }
    }
}
