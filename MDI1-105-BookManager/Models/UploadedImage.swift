//
//  UploadedImage.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 27/09/25.
//

import Foundation
import SwiftData

@Model
class UploadedImage {
    var imageName: String
    @Attribute(.externalStorage) var imageData: Data?
    
    init(imageName: String, imageData: Data? = nil) {
        self.imageName = imageName
        self.imageData = imageData
    }
}
