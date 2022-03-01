//
//  CatView.swift
//  FurryFriends
//
//  Created by Claire Coding Account on 2022-02-28.
//

import SwiftUI

struct CatView: View {
    
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.primary, lineWidth: 3)
                )
                .padding()
            
            // Push main image to top of screen
            Spacer()

        }
        // Runs once when the app is opened
        .task {
            
            // Example images for each type of pet
            let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteCatImage)!
                        
        }
        .navigationTitle("Furry Cat Friends")
        
    }
    
    // MARK: Functions
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        CatView()
        }
    }
}
