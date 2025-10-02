//
//  ImageField.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 27/09/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ImageField: View {
    
    @Binding var image: UIImage?
    @State private var photosPicketItem: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(
            selection: $photosPicketItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Image(uiImage: image ?? UIImage(resource: .defaultBook))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
        }
        .onChange(of: photosPicketItem) { _, _ in
            Task {
                if let photosPicketItem,
                   let imageData = try? await photosPicketItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: imageData) {
                        self.image = image
                    }
                }
            }
        }
    }
}
