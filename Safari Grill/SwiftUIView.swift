//
//  SwiftUIView.swift
//  Safari Grill
//
//  Created by Jay Jayaprakash on 23/08/2023.
//

import SwiftUI

struct TestImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(urlString: String) {
        imageLoader = ImageLoader(urlString: urlString)
    }
    
    var body: some View {
        if let uiImage = imageLoader.image {
             uiImage
                .resizable()
                .scaledToFit() // Add any modifiers you need for the image
        } else {
            Text("Loading") // Replace with your placeholder image
        }
    }
}

#Preview {
    TestImageView(urlString: "https://firebasestorage.googleapis.com/v0/b/safarigrill-5dd26.appspot.com/o/Smashed-Avo-1200x1219.jpg?alt=media&token=96b8baa7-2768-4263-9adf-278b03598f5a")
}

