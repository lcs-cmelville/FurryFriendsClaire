//
//  ContentView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentDog: Dog = Dog(message: "",
                                     status: "")
    
    @State var favourites: [Dog] = []
    
    @State var currentDogAddedToFavourites: Bool = false
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Shows the main image
            Image(currentDog.message)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.primary, lineWidth: 3)
                )
                .padding()
            
            Button(action: {
                
                Task{
                await loadNewDog()
                }
            }, label: {
                Text("Another!")
            })
                .buttonStyle(.bordered)
            
            // Push main image to top of screen
            Spacer()

            Text("Favourites")
            
            List(favourites, id: \.self) { currentFavourite in
                Text(currentFavourite.message)
                
            }

        }
        // Runs once when the app is opened
        .task {
  
            await loadNewDog()
            
            print("I tried")
                        
        }
        .navigationTitle("Furry Dog Friends")
        .padding()
        
    }
    
    // MARK: Functions
    
    func loadNewDog() async {
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new joke
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentDog = try JSONDecoder().decode(Dog.self, from: data)
            
            // Reset the flag that tracks whether the current joke is a favourite
            currentDogAddedToFavourites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
