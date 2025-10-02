//
//  ImageViewer.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 27/09/25.
//

import SwiftUI
import SwiftData

struct ImageViewer: View {
    @Query var images: [UploadedImage]
    
    var body: some View {
        NavigationStack {
            VStack {
                if images.isEmpty {
                    Text("No images found")
                } else {
                    List(images, id: \.id) { image in
                        HStack {
                            Image(
                                uiImage: UIImage(
                                    data: (image.imageData as Data?)!) ?? UIImage(resource: .defaultBook)
                            )
                            .resizable()
                            .frame(width: 100, height: 100)
                            Text(image.imageName)
                        }
                    }
                }
            }
            .navigationTitle("Images")
        }
    }
}
