//
//  ContentView.swift
//  Programming Jokes
//
//  Created by 이소은 on 2022/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes = [Joke]()
    @State private var showingAlert = false
    
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
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Loading Error"),
            message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("Ok")))
        }
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key = 758f477fdcmsh2b78f5fdd0bf86bp1ccc3fjsnbd45cb1f4332"
        let query = "https://dad-jokes.p.rapidapi.com/joke/type/programming\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents{
                        let setup = item["setup"].stringValue
                        let punchline = item["punchline"].stringValue
                        let joke = Joke(setup: setup, punchline: punchline)
                        jokes.append(joke)
                    }
                }
            }
        }
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


