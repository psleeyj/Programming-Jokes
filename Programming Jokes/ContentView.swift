//
//  ContentView.swift
//  Programming Jokes
//
//  Created by 이소은 on 2022/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes = [Joke]()
    
    var body: some View {
        NavigationView {
            List(jokes) { joke in
                NavigationLink(destination : Text(joke.punchline)
                    .padding()) {
                        Text(joke.setup)
                    }
            }
            .navigationTitle("Programming Jokes")
        }
        .onAppear() {
            getJokes()
        }
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key = 758f477fdcmsh2b78f5fdd0bf86bp1ccc3fjsnbd45cb1f4332"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke : Identifiable {
    let id = UUID()
    var setup = ""
    var punchline = ""
}


