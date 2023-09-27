//
//  MyImage+Extension.swift
//  My Images CD
//
//  Created by Obde Willy on 02/01/23.
//

import UIKit

extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID) {
            return image
        } else {
            if let image = UIImage(systemName: "photo") {
                return image
            } else {
                return UIImage()
            }
        }
    }
    
    var commentView: String {
        comment ?? ""
    }
    
    var receivedFromView: String {
        receiveFrom ?? ""
    }
}
